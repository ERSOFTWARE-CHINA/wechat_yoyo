defmodule ApiServerWeb.UserVipController do
  use ApiServerWeb, :controller

  use ApiServer.UserVipContext
  alias ApiServer.UserContext.User
  alias ApiServer.VipCardContext.VipCard

  action_fallback ApiServerWeb.FallbackController

  def get_my(conn, %{"openid" => openid}) do
    user_vip = get_by_user(openid, [:vip_card])
    render(conn, "show.json", user_vip: user_vip)
  end

  # 第一次购买会员卡为创建，非第一次购买为更新
  def buy(conn, %{"card_id" => card_id, "openid" => openid}) do
    user_changeset = get_user_changeset(openid)
    {vip_card, card_changeset} = get_card_changeset(card_id)
    openid
    |> get_by_user([:user, :vip_card])
    |> case do
      nil ->
        user_vip_changeset = UserVip.changeset(%UserVip{}, %{remainder: vip_card.value})
        |> Ecto.Changeset.put_assoc(:user, user_changeset)
        |> Ecto.Changeset.put_assoc(:vip_card, card_changeset)
        with {:ok, %UserVip{} = user_vip} <- save_create(user_vip_changeset) do
          render(conn, "show.json", user_vip: user_vip)
        end
      user_vip ->
        old_vip_card = get_card_by_id(user_vip.vip_card_id)
        case old_vip_card.level > vip_card.level do
          true ->
            user_vip_changeset = UserVip.changeset(user_vip, %{remainder: user_vip.remainder + vip_card.value})
            |> Ecto.Changeset.put_assoc(:user, user_changeset)
            with {:ok, %UserVip{} = user_vip} <- save_update(user_vip_changeset) do
              render(conn, "show.json", user_vip: user_vip)
            end
        
          false ->
            user_vip_changeset = UserVip.changeset(user_vip, %{remainder: user_vip.remainder + vip_card.value})
            |> Ecto.Changeset.put_assoc(:user, user_changeset)
            |> Ecto.Changeset.put_assoc(:vip_card, card_changeset)
            with {:ok, %UserVip{} = user_vip} <- save_update(user_vip_changeset) do
              render(conn, "show.json", user_vip: user_vip)
            end
        end
    end
  end

  defp get_user_changeset(openid) do
    openid
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, wechat_openid: open_id) do
          {:error, _} -> nil
          {:ok, user} -> change(User, user)
        end
    end
  end

  defp get_card_changeset(card_id) do
    card_id
    |> case do
      nil -> nil
      id ->
        case get_by_id(VipCard, id) do
          {:error, _} -> nil
          {:ok, vip_card} -> {vip_card, change(VipCard, vip_card)}
        end
    end
  end

  defp get_card_by_id(card_id) do
    case get_by_id(VipCard, card_id) do
      {:error, _} -> nil
      {:ok, vip_card} -> vip_card
    end
  end
end

defmodule ApiServerWeb.UserVipController do
  use ApiServerWeb, :controller

  use ApiServer.UserVipContext
  alias ApiServer.UserContext.User
  alias ApiServer.VipCardContext.VipCard

  action_fallback ApiServerWeb.FallbackController

  def get_my(conn, %{"openid" => openid}) do
    user_vip = get_by_user(openid)
    render(conn, "show.json", user_vip: user_vip)
  end

  # 第一次购买会员卡为创建，非第一次购买为更新
  def buy(conn, %{"card_id" => card_id, "openid" => openid}) do
    user_changeset = get_user_changeset(openid)
    card_changeset = get_card_changeset(card_id)
    openid
    |> get_by_user
    |> case do
      nil ->
        user_vip_changeset = UserVip.changeset(%Order{}, %{})
        |> Ecto.Changeset.put_assoc(:user, user_changeset)
        |> Ecto.Changeset.put_assoc(:vip_card, card_changeset)
        with {:ok, %UserVip{} = user_vip} <- save_create(user_vip_changeset) do
          render(conn, "show.json", user_vip: user_vip)
        end
      user_vip ->
        user_vip_changeset = UserVip.changeset(%Order{}, user_vip)
        |> Ecto.Changeset.put_assoc(:user, user_changeset)
        |> Ecto.Changeset.put_assoc(:vip_card, card_changeset)
        with {:ok, %UserVip{} = user_vip} <- save_update(user_vip_changeset) do
          render(conn, "show.json", user_vip: user_vip)
        end
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("open_id")
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, open_id: open_id) do
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
          {:ok, vip_card} -> change(VipCard, vip_card)
        end
    end
  end
end

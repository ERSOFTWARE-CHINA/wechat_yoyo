defmodule ApiServer.UserVipContext do
  @moduledoc """
  The UserVipContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.UserVipContext.UserVip
  alias ApiServer.VipCardContext.VipCard
  alias ApiServer.UserContext.User
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.UserVipContext
      use ApiServer.BaseContext
      alias ApiServer.UserVipContext.UserVip
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(open_id: open_id)
    UserVip
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> get_pagination(params)
  end

  def page(params) do 
    UserVip
    |> query_order_desc_by(params, "dt")
    |> get_pagination(params)
  end

  def get_by_user(open_id, preload_list \\ []) do
    {:ok, user} = User
    |> get_by_name(wechat_openid: open_id)
    UserVip
    |> get_by_name(%{user_id: user.id}, preload_list)
    |> case do
      {:ok, user_vip} -> user_vip
      {_, _} -> nil
    end
  end

  def buy_success(user, vip_card) do
    user_changeset = User.changeset(user, %{})
    card_changeset = VipCard.changeset(vip_card, %{})
    user.wechat_openid
    |> get_by_user([:user, :vip_card])
    |> case do
      nil ->
        user_vip_changeset = UserVip.changeset(%UserVip{}, %{remainder: vip_card.value})
        |> Ecto.Changeset.put_assoc(:user, user_changeset)
        |> Ecto.Changeset.put_assoc(:vip_card, card_changeset)
        |> save_create
      user_vip ->
        old_vip_card = user_vip.vip_card
        case old_vip_card.level > vip_card.level do
          true ->
            user_vip_changeset = UserVip.changeset(user_vip, %{remainder: user_vip.remainder + vip_card.value})
            |> Ecto.Changeset.put_assoc(:user, user_changeset)
            |> save_update
        
          false ->
            user_vip_changeset = UserVip.changeset(user_vip, %{remainder: user_vip.remainder + vip_card.value})
            |> Ecto.Changeset.put_assoc(:user, user_changeset)
            |> Ecto.Changeset.put_assoc(:vip_card, card_changeset)
            |> save_update
        end
    end
  end


  
end

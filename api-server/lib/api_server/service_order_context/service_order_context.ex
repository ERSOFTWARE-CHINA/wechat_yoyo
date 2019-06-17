defmodule ApiServer.ServiceOrderContext do
  @moduledoc """
  The ServiceOrderContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo
  alias Ecto.Multi

  alias ApiServer.ServiceOrderContext.ServiceOrder
  alias ApiServer.UserContext.User
  alias ApiServer.UserVipContext.UserVip
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.ServiceOrderContext
      use ApiServer.BaseContext
      alias ApiServer.ServiceOrderContext.ServiceOrder
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(open_id: open_id)
    ServiceOrder
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "status")
    |> get_pagination(params)
  end

  def page(params) do 
    ServiceOrder
    |> query_like(params, "sname")
    |> query_equal(params, "status")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end
  
  def buy_service(params) do 
    params
    |> get_buy_multi
    |> Repo.transaction
  end

  def get_buy_multi(%{user: user, service: service, amount: amount, pay_type: pay_type, changeset: changeset}) do
    multi = Multi.new

    case pay_type do
      "优悠账户" ->
        # 更新user_vip, 账号支付的情况
        {:ok, user_vip} = UserVip
        |> get_by_name(user_id: user.id)
        user_vip_changeset = user_vip
        |> UserVip.changeset(%{remainder: user_vip.remainder - service.current_price * amount})
        multi
        |> Multi.update("update_user_vip", user_vip_changeset)
        |> Multi.insert("update_service_order", changeset)
      "微信" ->
        multi
        |> Multi.insert("update_service_order", changeset)
      _ -> multi
    end
  end

end

defmodule ApiServer.OrderContext do
  @moduledoc """
  The OrderContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.OrderContext.Order
  alias ApiServer.UserContext.User
  alias ApiServer.CommodityContext.Commodity
  alias ApiServer.UserVipContext
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.OrderContext
      use ApiServer.BaseContext
      alias ApiServer.OrderContext.Order
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(wechat_openid: open_id)
    Order
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "status")
    |> get_pagination(params)
  end

  def page(params) do 
    Order
    |> query_equal(params, "status")
    |> query_equal(params, "pay_status")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end

  def get_current_order_no() do
    Order
    |> get_max(:ono)
  end

  # 账户支付
  def pay_by_vip(order) do
    user_vip = UserVipContext.get_by_user(order.user.wechat_openid)
    cond do
      user_vip.remainder - order.amount * order.commodity.current_price >= 0 ->
        ApiServer.Repo.transaction(fn ->
          update_order(order)
          update_commodity(order)
          update_user_vip(order, user_vip)
          create_consumption_record(order, 1)
        end)
      true ->
        {:error, "Insufficient Balance"}
    end
  end

  # 微信支付成功回调函数
  def pay_success(params) do 
    ono = params
    |> Map.get("out_trade_no")
    {:ok, order} = Order
    |> get_by_name(%{ono: ono}, [:user, :commodity]) 

    ApiServer.Repo.transaction(fn ->
      update_order(order)
      update_commodity(order)
      create_consumption_record(order, 0)
    end)
  end

  # 账户支付的情况：扣除账户金额
  def update_user_vip(order, user_vip) do
    UserVip.changset(user_vip, %{ remainder: user_vip.remainder - order.amount })
    |> save_update
  end

  # 支付成功后更新订单支付状态
  defp update_order(order) do
    Order.changeset(order, %{pay_status: true})
    |> save_update
  end

  # 修改产品库存量
  defp update_commodity(order) do
    {:ok, commodity} = Commodity
    |> get_by_id(order.commodity.id)
    Commodity.changeset(commodity, %{stock: commodity.stock - order.amount})
    |> save_update
  end

  # 创建消费记录
  defp create_consumption_record(order, pay_type) do
    user = order.user
    change = %{
      name: order.commodity.cname,
      type: 1, 
      pay_type: pay_type,
      quantity: order.amount,
      amount: order.commodity.current_price * order.amount,
      datetime: ApiServer.Utils.DatetimeHandler.get_now_str
    }
    user_changeset = change(User, user)
    ConsumptionRecord.changeset(%ConsumptionRecord{}, change)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> save_create
  end

end

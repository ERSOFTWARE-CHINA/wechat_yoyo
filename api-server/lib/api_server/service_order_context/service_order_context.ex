defmodule ApiServer.ServiceOrderContext do
  @moduledoc """
  The ServiceOrderContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo
  alias Ecto.Multi

  alias ApiServer.ServiceOrderContext.ServiceOrder
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service
  alias ApiServer.UserVipContext.UserVip
  alias ApiServer.UserVipContext
  alias ApiServer.ConsumptionRecordContext.ConsumptionRecord
  alias ApiServer.UserServiceContext
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
    |> get_by_name(wechat_openid: open_id)
    ServiceOrder
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "status")
    |> query_preload([:service, :user])
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end

  def page(params) do 
    ServiceOrder
    |> query_like(params, "sname")
    |> query_equal(params, "status")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end

  def get_current_order_no() do
    ServiceOrder
    |> get_max(:sno) 
  end

  # 账户支付
  def pay_by_vip(order) do
    user_vip = UserVipContext.get_by_user(order.user.wechat_openid, [:user, :vip_card])
    cond do
      user_vip.remainder - order.amount * order.service.current_price >= 0 ->
        ApiServer.Repo.transaction(fn ->
          update_order(order)
          # update_commodity(order)
          update_user_vip(order, user_vip)
          create_consumption_record(order, 1)
          create_or_update_user_service(order)
        end)
      true ->
        {:error, "Insufficient Balance"}
    end
  end

  # 微信支付成功回调函数
  def pay_success(params) do 
    sno = params
    |> Map.get("out_trade_no")
    {:ok, order} = ServiceOrder
    |> get_by_name(%{sno: sno}, [:user, :service]) 

    ApiServer.Repo.transaction(fn ->
      update_order(order)
      create_consumption_record(order, 0)
      create_or_update_user_service(order)
    end)
  end


  # 账户支付的情况：扣除账户金额
  def update_user_vip(order, user_vip) do
    UserVip.changeset(user_vip, %{ remainder: user_vip.remainder - order.amount * order.service.current_price})
    |> save_update
  end

  # 支付成功后更新订单支付状态
  defp update_order(order) do
    ServiceOrder.changeset(order, %{pay_status: true})
    |> save_update
  end

  # 创建消费记录
  defp create_consumption_record(order, pay_type) do
    p = %{
      name: order.service.sname,
      type: 2,
      pay_type: pay_type,
      quantity: order.amount,
      amount: order.amount * order.service.current_price, 
      user_id: order.user.id
    }
    ConsumptionRecord.changeset(%ConsumptionRecord{}, p)
    |> save_create
  end

  # 创建或修改用户对应服务次数记录
  defp create_or_update_user_service(order) do
    user_id = order.user.id
    service_id = order.service.id
    UserServiceContext.get_by_user_and_service(user_id, service_id)
    |> case do
      nil ->
        UserServiceContext.create(user_id, service_id, order.amount * order.service.times)
      rd ->
        UserServiceContext.UserService.changeset(rd, %{times: rd.times + order.amount * order.service.times})
        |> Repo.update
    end
  end


end

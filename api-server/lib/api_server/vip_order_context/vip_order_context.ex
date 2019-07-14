defmodule ApiServer.VipOrderContext do
  @moduledoc """
  The VipOrderContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo
  alias Ecto.Multi

  alias ApiServer.VipOrderContext.VipOrder
  alias ApiServer.UserVipContext.UserVip
  alias ApiServer.UserVipContext
  alias ApiServer.UserContext.User
  alias ApiServer.ConsumptionRecordContext.ConsumptionRecord
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.VipOrderContext
      use ApiServer.BaseContext
      alias ApiServer.VipOrderContext.VipOrder
    end
  end

  # 支付成功回调函数(微信)
  def pay_success(params) do 
    vno = params
    |> Map.get("out_trade_no")
    {:ok, vip_order} = VipOrder
    |> get_by_name(%{vno: vno}, [:user, :vip_card]) 

    ApiServer.Repo.transaction(fn ->
      create_consumption_record(vip_order.vip_card, vip_order.user)
      update_vip_order(vip_order)
      update_user_vip(vip_order.user, vip_order.vip_card)
    end)
  end

  def get_current_order_no() do
    VipOrder
    |> get_max(:vno) 
  end

  # 支付成功后更新订单
  defp update_vip_order(vip_order) do
    VipOrder.changeset(vip_order, %{pay_status: true})
    |> save_update
  end

  # 支付成功后更新账户user_vip
  defp update_user_vip(user, vip_card) do
    ApiServer.UserVipContext.buy_success(user, vip_card)
  end

  # 创建消费记录
  defp create_consumption_record(vip_card, user) do
    change = %{
      name: vip_card.name,
      type: 0, pay_type: 0,
      quantity: 1,
      amount: vip_card.price,
      datetime: ApiServer.Utils.DatetimeHandler.get_now_str
    }
    user_changeset = change(User, user)
    ConsumptionRecord.changeset(%ConsumptionRecord{}, change)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> save_create
  end
  
end
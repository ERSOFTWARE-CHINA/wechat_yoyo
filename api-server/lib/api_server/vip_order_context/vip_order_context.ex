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
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.VipOrderContext
      use ApiServer.BaseContext
      alias ApiServer.VipOrderContext.VipOrder
    end
  end

  # 支付成功回调函数
  def pay_success(params) do 
    vno = params
    |> Map.get("out_trade_no")
    {:ok, vip_order} = VipOrder
    |> get_by_name(%{vno: vno}, [:user, :vip_card]) 

    ApiServer.Repo.transaction(fn ->
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
  
end
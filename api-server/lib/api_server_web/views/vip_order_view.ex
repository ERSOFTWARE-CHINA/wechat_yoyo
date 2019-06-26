defmodule ApiServerWeb.VipOrderView do
  use ApiServerWeb, :view
  alias ApiServerWeb.VipOrderView

  def render("index.json", %{vip_orders: vip_orders}) do
    %{data: render_many(vip_orders, VipOrderView, "vip_order.json")}
  end

  def render("show.json", %{vip_order: vip_order}) do
    %{data: render_one(vip_order, VipOrderView, "vip_order.json")}
  end

  def render("vip_order.json", %{vip_order: vip_order}) do
    %{id: vip_order.id,
      vno: vip_order.vno}
  end
end

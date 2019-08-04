defmodule ApiServerWeb.OrderView do
  use ApiServerWeb, :view
  alias ApiServerWeb.OrderView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, OrderView, "order.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      ono: order.ono,
      commodity: order.commodity.cname,
      price: order.commodity.current_price,
      amount: order.amount,
      pay_status: order.pay_status |> parse_pay_status,
      status: order.status |> parse_status,
      delivery_info: order.delivery_info,
      name: order.user.name,
      address: order.user.address,
      mobile: order.user.mobile,
      date: order.date
    }
  end

  defp parse_pay_status(value) do
    value
    |> case do
      true ->  "已支付"
      false -> "未支付"
    end
  end

  defp parse_status(value) do
    value
    |> case do
      "a" -> "未发货"
      "c" -> "已取消"
      "d" -> "已发货"
    end
  end
end

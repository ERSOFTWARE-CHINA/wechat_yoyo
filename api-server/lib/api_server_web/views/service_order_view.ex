defmodule ApiServerWeb.ServiceOrderView do
  use ApiServerWeb, :view
  alias ApiServerWeb.ServiceOrderView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, ServiceOrderView, "service_order.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{service_order: service_order}) do
    %{data: render_one(service_order, ServiceOrderView, "service_order.json")}
  end

  def render("service_order.json", %{service_order: service_order}) do
    %{
      id: service_order.id,
      sno: service_order.sno,
      service: service_order.service.sname,
      price: service_order.service.current_price,
      amount: service_order.amount,
      pay_status: service_order.pay_status |> parse_pay_status,
      status: service_order.status |> parse_status,
      date: service_order.date
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
      "a" -> "正常"
      "c" -> "已取消"
    end
  end

end

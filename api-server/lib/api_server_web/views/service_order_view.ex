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
    %{id: service_order.id,
      status: service_order.status}
  end
end

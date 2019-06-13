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
      id: order.id
    }
  end
end

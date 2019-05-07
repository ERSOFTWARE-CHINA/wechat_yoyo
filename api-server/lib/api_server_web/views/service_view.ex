defmodule ApiServerWeb.ServiceView do
  use ApiServerWeb, :view
  alias ApiServerWeb.ServiceView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, CommodityView, "service.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{service: service}) do
    %{data: render_one(service, ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    %{id: service.id,
      sname: service.sname}
  end
end

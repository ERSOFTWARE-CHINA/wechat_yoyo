defmodule ApiServerWeb.CommodityView do
  use ApiServerWeb, :view
  alias ApiServerWeb.CommodityView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, CommodityView, "commodity.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{commodity: commodity}) do
    %{data: render_one(commodity, CommodityView, "commodity.json")}
  end

  def render("commodity.json", %{commodity: commodity}) do
    %{id: commodity.id,
      cname: commodity.cname}
  end
end

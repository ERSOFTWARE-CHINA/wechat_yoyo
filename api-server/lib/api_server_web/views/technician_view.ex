defmodule ApiServerWeb.TechnicianView do
  use ApiServerWeb, :view
  alias ApiServerWeb.TechnicianView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, TechnicianView, "commodity.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{technician: technician}) do
    %{data: render_one(technician, TechnicianView, "technician.json")}
  end

  def render("technician.json", %{technician: technician}) do
    %{id: technician.id,
      name: technician.name}
  end
end

defmodule ApiServerWeb.AppointmentView do
  use ApiServerWeb, :view
  alias ApiServerWeb.AppointmentView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, AppointmentView, "appointment.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{appointment: appointment}) do
    %{data: render_one(appointment, AppointmentView, "appointment.json")}
  end

  def render("appointment.json", %{appointment: appointment}) do
    %{
      id: appointment.id,
      date: appointment.date,
      time: appointment.time
    }
  end
end

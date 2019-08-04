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
      time: appointment.time,
      technician: appointment.technician.name,
      user: appointment.user.full_name,
      service: appointment.service.sname,
      status: appointment.status |> parse_status
    }
  end

  defp parse_status(status) do
    status
    |> case do
      "0" -> "已预约"
      "1" -> "已完成"
      "-1" -> "已取消"
    end
  end
end

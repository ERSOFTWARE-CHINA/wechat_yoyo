defmodule ApiServerWeb.TechnicianView do
  use ApiServerWeb, :view
  alias ApiServerWeb.TechnicianView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, TechnicianView, "technician.json"),
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
    %{
      id: technician.id,
      name: technician.name,
      occupation: technician.occupation,
      characteristic: technician.characteristic |> parse_characteristic,
      order_times: technician.order_times,
      works: technician.works,
      good_times: technician.good_times,
      rank: div(technician.good_times || 0, technician.order_times || 1),
      order_times: technician.order_times,
      avatar: getPicUrl(technician)

    }
  end

  # 获avatar图片url
  defp getPicUrl(technician) do
    case technician.avatar do
      nil -> ""
      avatar -> 
        url = ApiServerWeb.StringHandler.take_prefix(ApiServer.TechnicianAvatarImage.url({technician.avatar, technician}, :original),"/priv/static")  
        base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
        base<>url
    end
  end

  # 
  defp parse_characteristic(str) do
    str
    |> String.split( ",")
  end
end

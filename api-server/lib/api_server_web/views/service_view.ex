defmodule ApiServerWeb.ServiceView do
  use ApiServerWeb, :view
  alias ApiServerWeb.ServiceView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, ServiceView, "service.json"),
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
    %{
      id: service.id,
      sname: service.sname,
      original_price: service.original_price,
      current_price: service.current_price,
      desc: service.desc,
      image_01: get_image_01(service),
      image_detail: get_image_detail(service)
    }
  end

  defp get_image_01(service) do
    case service.image_01 do
      nil -> ""
      image_01 -> 
        url = ApiServerWeb.StringHandler.take_prefix(ApiServer.ServiceImage.url({service.image_01, service}, :original),"/priv/static")  
        base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
        base<>url
    end
  end

  defp get_image_detail(service) do
    case service.image_detail do
      nil -> ""
      image_detail -> 
        url = ApiServerWeb.StringHandler.take_prefix(ApiServer.ServiceImageDetail.url({service.image_detail, service}, :original),"/priv/static")  
        base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
        base<>url
    end
  end
end

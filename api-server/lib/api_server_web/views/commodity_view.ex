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
    %{
      id: commodity.id,
      cname: commodity.cname,
      original_price: commodity.original_price,
      current_price: commodity.current_price,
      stock: commodity.stock,
      desc: commodity.desc,
      image_01: get_image_01(commodity),
      image_02: get_image_02(commodity),
      image_03: get_image_03(commodity),
      image_detail: get_image_detail(commodity)
    }
  end

    # 图片url
    defp get_image_01(commodity) do
      case commodity.image_01 do
        nil -> ""
        image_01 -> 
          url = ApiServerWeb.StringHandler.take_prefix(ApiServer.CommodityImageOne.url({commodity.image_01, commodity}, :original),"/priv/static")  
          base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
          base<>url
      end
    end

    # 图片url
    defp get_image_01(commodity) do
      case commodity.image_01 do
        nil -> ""
        image_01 -> 
          url = ApiServerWeb.StringHandler.take_prefix(ApiServer.CommodityImageOne.url({commodity.image_01, commodity}, :original),"/priv/static")  
          base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
          base<>url
      end
    end

    # 图片url
    defp get_image_02(commodity) do
      case commodity.image_02 do
        nil -> ""
        image_02 -> 
          url = ApiServerWeb.StringHandler.take_prefix(ApiServer.CommodityImageTwo.url({commodity.image_02, commodity}, :original),"/priv/static")  
          base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
          base<>url
      end
    end

    # 图片url
    defp get_image_03(commodity) do
      case commodity.image_03 do
        nil -> ""
        image_03 -> 
          url = ApiServerWeb.StringHandler.take_prefix(ApiServer.CommodityImageThree.url({commodity.image_03, commodity}, :original),"/priv/static")  
          base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
          base<>url
      end
    end

    # 图片url
    defp get_image_detail(commodity) do
      case commodity.image_detail do
        nil -> ""
        image_detail -> 
          url = ApiServerWeb.StringHandler.take_prefix(ApiServer.CommodityImageDetail.url({commodity.image_detail, commodity}, :original),"/priv/static")  
          base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
          base<>url
      end
    end
end

defmodule ApiServerWeb.PostView do
  use ApiServerWeb, :view
  alias ApiServerWeb.PostView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, PostView, "post.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      title: post.title,
      date: post.date,
      good: post.good,
      author: render_one(post.technician, ApiServerWeb.TechnicianView, "technician.json"),
      post_images: post.post_images
      |> Enum.reduce([], fn(pi, acc) -> 
        [%{url: pi |> get_post_image} | acc]
      end)
      # render_many(post.post_images, PostView, "post_image.json")

    }
  end

  # def render("post_image.json", %{post_image: post_image}) do
  #   %{
  #     url: get_post_image(post_image)
  #   }
  # end


  defp getPicUrl(technician) do
    case technician.avatar do
      nil -> ""
      avatar -> 
        url = ApiServerWeb.StringHandler.take_prefix(ApiServer.TechnicianAvatarImage.url({technician.avatar, technician}, :original),"/priv/static")  
        base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
        base<>url
    end
  end

  defp get_post_image(post_image) do
    case post_image.image do
      nil -> ""
      image -> 
        url = ApiServerWeb.StringHandler.take_prefix(ApiServer.PostImageImage.url({image, post_image}, :original),"/priv/static")  
        base = Application.get_env(:api_server, ApiServerWeb.Endpoint)[:baseurl]
        base<>url
    end
  end
end

defmodule ApiServerWeb.PostView do
  use ApiServerWeb, :view
  alias ApiServerWeb.PostView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, RoomLayoutView, "room_layout.json"),
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
    %{id: post.id,
      title: post.title}
  end
end

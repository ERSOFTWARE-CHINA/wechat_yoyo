defmodule ApiServerWeb.PostController do
  use ApiServerWeb, :controller

  alias ApiServer.PostContext
  alias ApiServer.PostContext.Post

  action_fallback ApiServerWeb.FallbackController

  def index(conn, _params) do
    posts = PostContext.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- PostContext.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = PostContext.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = PostContext.get_post!(id)

    with {:ok, %Post{} = post} <- PostContext.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = PostContext.get_post!(id)

    with {:ok, %Post{}} <- PostContext.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end

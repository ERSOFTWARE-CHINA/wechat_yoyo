defmodule ApiServerWeb.PostController do
  use ApiServerWeb, :controller

  use ApiServer.PostContext

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, post_params) do
    post_changeset = Post.changeset(%Post{}, post_params)
    with {:ok, %Post{} = post} <- save_create(post_changeset) do
      render(conn, "show.json", post_layout: post)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- get_by_id(Post, id, [:post_comments, :user, :post_images]) do
      render(conn, "show.json", post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    with {:ok, post} <- get_by_id(Post, id) do
      post_changeset = Post.changeset(post, post_params)
      with {:ok, %Post{} = post} <- save_update(post_changeset) do
        render(conn, "show.json", post: post)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Post{} = post} <- delete_by_id(Post, id) do
      render(conn, "show.json", post: post)
    end
  end
end

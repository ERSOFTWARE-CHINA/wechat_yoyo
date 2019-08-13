defmodule ApiServerWeb.PostController do
  use ApiServerWeb, :controller

  use ApiServer.PostContext

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, post_params) do
    technician_changeset = get_technician_changeset(post_params)
    post_changeset = Post.changeset(%Post{}, post_params)
    |> Ecto.Changeset.put_assoc(:technician, technician_changeset)
    with {:ok, %Post{} = post} <- save_create(post_changeset) do
      render(conn, "show.json", post_layout: post)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- get_by_id(Post, id, [:post_comments, :technician, :post_images]) do
      render(conn, "show.json", post: post)
    end
  end

  def update(conn, %{"id" => id} = post_params) do
    with {:ok, post} <- get_by_id(Post, id, [:technician, :post_comments, :post_images]) do
      technician_changeset = get_technician_changeset(post_params)
      post_changeset = Post.changeset(post, post_params)
      |> Ecto.Changeset.put_assoc(:technician, technician_changeset)
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

  defp get_technician_changeset(params) do
    params
    |> Map.get("technician", %{})
    |> Map.get("id")
    |> case do
      nil -> nil
      id ->
        case get_by_id(Technician, id) do
          {:error, _} -> nil
          {:ok, user} -> change(Technician, user)
        end
    end
  end
end

defmodule ApiServerWeb.PostController do
  use ApiServerWeb, :controller

  use ApiServer.PostContext

  alias ApiServer.TechnicianContext.Technician
  alias ApiServer.PostImageContext.PostImage

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, post_params) do
    post_images_changesets = post_params |> get_images
    technician_changeset = get_technician_changeset(post_params)
    post_changeset = Post.changeset(%Post{}, post_params)
    |> Ecto.Changeset.put_assoc(:technician, technician_changeset)
    |> Ecto.Changeset.put_assoc(:post_images, post_images_changesets)
    with %Post{} = post <- save_create_with_preload(post_changeset, [:post_images]) do
      render(conn, "show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- get_by_id(Post, id, [:post_comments, :technician, :post_images]) do
      render(conn, "show.json", post: post)
    end
  end

  # 移动端调用
  def update(conn, %{"id" => id, "add_good" => true} = post_params) do
    with {:ok, post} <- get_by_id(Post, id, [:technician, :post_comments, :post_images]) do
      post_changeset = Post.changeset(post, post_params)
      with %Post{} = post <- save_update_with_preload(post_changeset, [:post_images]) do
        render(conn, "show.json", post: post)
      end
    end
  end

  def update(conn, %{"id" => id} = post_params) do
    with {:ok, post} <- get_by_id(Post, id, [:technician, :post_comments, :post_images]) do
      post_images_changesets = post_params |> get_images
      technician_changeset = get_technician_changeset(post_params)
      post_changeset = Post.changeset(post, post_params)
      |> Ecto.Changeset.put_assoc(:technician, technician_changeset)
      |> Ecto.Changeset.put_assoc(:post_images, post_images_changesets)
      with %Post{} = post <- save_update_with_preload(post_changeset, [:post_images]) do
        render(conn, "show.json", post: post)
      end
    end
  end

  

  def delete(conn, %{"id" => id}) do
    with {:ok, %Post{} = post} <- delete_by_id(Post, id, [:technician, :post_images, :post_comments]) do
      render(conn, "show.json", post: post)
    end
  end

  defp get_technician_changeset(params) do
    params
    |> Map.get("technician")
    |> case do
      nil -> nil
      id ->
        case get_by_id(Technician, id) do
          {:error, _} -> nil
          {:ok, user} -> change(Technician, user)
        end
    end
  end

  defp get_images(params) do
    images = []
    params
    |> Enum.reduce([], fn({k, v}, acc) -> 
      v
      |> case do
        %Plug.Upload{} -> [PostImage.changeset(%PostImage{}, %{image: v}) | acc]
        _ -> acc
      end
    end)
  end
end

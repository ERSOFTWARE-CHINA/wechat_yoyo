defmodule ApiServerWeb.PostCommentController do
  use ApiServerWeb, :controller

  use ApiServer.PostCommentContext
  alias ApiServer.UserContext.User
  alias ApiServer.PostContext.Post

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"post_comment" => post_comment_params}) do
    user_changeset = get_user_changeset(post_comment_params)
    post_changeset = get_post_changeset(post_comment_params)
    comment_changeset = PostComment.changeset(%PostComment{}, post_comment_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:post, post_changeset)
    with {:ok, %PostComment{} = post_comment} <- save_create(comment_changeset) do
      render(conn, "show.json", post_comment: post_comment)
    end
  end 

  def show(conn, %{"id" => id}) do
    with {:ok, post_comment} <- get_by_id(PostComment, id, [:post, :user]) do
      render(conn, "show.json", post_comment: post_comment)
    end
  end

  def update(conn, %{"id" => id, "post_comment" => post_comment_params}) do
    {:ok, post_comment} = get_by_id(PostComment, id, [:post, :user])
    user_changeset = get_user_changeset(post_comment_params)
    post_changeset = get_post_changeset(post_comment_params)
    comment_changeset = PostComment.changeset(post_comment, post_comment_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:post, post_changeset)
    with {:ok, %PostComment{} = post_comment} <- save_update(comment_changeset) do
      render(conn, "show.json", post_comment: post_comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %PostComment{} = post_comment} <- delete_by_id(PostComment, id, [:post, :user]) do
      render(conn, "show.json", post_comment: post_comment)
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("open_id")
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, open_id: open_id) do
          {:error, _} -> nil
          {:ok, user} -> change(User, user)
        end
    end
  end

  defp get_post_changeset(params) do
    params
    |> Map.get("post", %{})
    |> Map.get("id")
    |> case do
      nil -> nil
      id ->
        case get_by_id(Post, id) do
          {:error, _} -> nil
          {:ok, post} -> change(Post, post)
        end
    end
  end

end

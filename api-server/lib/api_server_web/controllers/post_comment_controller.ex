defmodule ApiServerWeb.PostCommentController do
  use ApiServerWeb, :controller

  alias ApiServer.PostCommentContext
  alias ApiServer.PostCommentContext.PostComment

  action_fallback ApiServerWeb.FallbackController

  def index(conn, _params) do
    post_comments = PostCommentContext.list_post_comments()
    render(conn, "index.json", post_comments: post_comments)
  end

  def create(conn, %{"post_comment" => post_comment_params}) do
    with {:ok, %PostComment{} = post_comment} <- PostCommentContext.create_post_comment(post_comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_comment_path(conn, :show, post_comment))
      |> render("show.json", post_comment: post_comment)
    end
  end

  def show(conn, %{"id" => id}) do
    post_comment = PostCommentContext.get_post_comment!(id)
    render(conn, "show.json", post_comment: post_comment)
  end

  def update(conn, %{"id" => id, "post_comment" => post_comment_params}) do
    post_comment = PostCommentContext.get_post_comment!(id)

    with {:ok, %PostComment{} = post_comment} <- PostCommentContext.update_post_comment(post_comment, post_comment_params) do
      render(conn, "show.json", post_comment: post_comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    post_comment = PostCommentContext.get_post_comment!(id)

    with {:ok, %PostComment{}} <- PostCommentContext.delete_post_comment(post_comment) do
      send_resp(conn, :no_content, "")
    end
  end
end

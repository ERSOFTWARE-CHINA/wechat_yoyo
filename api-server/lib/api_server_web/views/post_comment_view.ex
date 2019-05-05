defmodule ApiServerWeb.PostCommentView do
  use ApiServerWeb, :view
  alias ApiServerWeb.PostCommentView

  def render("index.json", %{post_comments: post_comments}) do
    %{data: render_many(post_comments, PostCommentView, "post_comment.json")}
  end

  def render("show.json", %{post_comment: post_comment}) do
    %{data: render_one(post_comment, PostCommentView, "post_comment.json")}
  end

  def render("post_comment.json", %{post_comment: post_comment}) do
    %{id: post_comment.id,
      content: post_comment.content}
  end
end

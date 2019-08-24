defmodule ApiServerWeb.PostCommentView do
  use ApiServerWeb, :view
  alias ApiServerWeb.PostCommentView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, PostCommentView, "post_comment.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{post_comment: post_comment}) do
    %{data: render_one(post_comment, PostCommentView, "post_comment.json")}
  end

  def render("post_comment.json", %{post_comment: post_comment}) do
    %{
      id: post_comment.id,
      content: post_comment.content,
      date: post_comment.date,
      user: post_comment.user.wechat_nickname,
      avatar: post_comment.user.wechat_avatar_url
    }
  end
end

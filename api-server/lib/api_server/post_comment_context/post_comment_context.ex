defmodule ApiServer.PostCommentContext do
  @moduledoc """
  The PostCommentContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.PostCommentContext.PostComment
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.PostCommentContext
      use ApiServer.BaseContext
      alias ApiServer.PostCommentContext.PostComment
    end
  end

  def page(params) do 
    Post
    |> query_like(params, "content")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end
end

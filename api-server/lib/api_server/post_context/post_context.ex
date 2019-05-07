defmodule ApiServer.PostContext do
  @moduledoc """
  The PostContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.PostContext.Post

  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.PostContext
      use ApiServer.BaseContext
      alias ApiServer.PostContext.Post
    end
  end

  def page(params) do 
    Post
    |> query_like(params, "title")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end
end

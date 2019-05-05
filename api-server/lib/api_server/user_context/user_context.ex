defmodule ApiServer.UserContext do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.UserContext.User
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.UserContext
      use ApiServer.BaseContext
      alias ApiServer.UserContext.User
    end
  end

  def page(params) do 
    User
    |> query_like(params, "wechat_nickname")
    |> query_like(params, "mobile")
    |> query_equal(params, "type")
    |> query_equal(params, "status")
    |> query_order_desc_by(params, "inserted_at")
    |> get_pagination(params)
  end

end

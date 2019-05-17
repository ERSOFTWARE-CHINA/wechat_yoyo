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
    |> query_like(params, "name")
    |> query_like(params, "wechat_nickname")
    |> query_like(params, "mobile")
    |> query_equal(params, "active")
    |> query_equal(params, "is_admin")
    |> query_order_by(params, "inserted_at")
    |> get_pagination(params)
  end

  def validate_user_name(params) do
    params
    |> Map.get("id", nil)
    |> case do
      nil ->
        name = params
        |> Map.get("name")
        case get_by_name(name: name) do
          nil -> {:ok, "ok"}
          entity -> {:eorror, "error"}
        end
      id ->
        User
        |> get_by_id(id)
    end
  end

end

defmodule ApiServer.ServiceOrderContext do
  @moduledoc """
  The ServiceOrderContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.ServiceOrderContext.ServiceOrder
  alias ApiServer.UserContext.User
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.ServiceOrderContext
      use ApiServer.BaseContext
      alias ApiServer.ServiceOrderContext.ServiceOrder
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(open_id: open_id)
    ServiceOrder
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "status")
    |> get_pagination(params)
  end

  def page(params) do 
    ServiceOrder
    |> query_like(params, "sname")
    |> query_equal(params, "status")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end
end

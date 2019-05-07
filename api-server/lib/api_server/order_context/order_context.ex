defmodule ApiServer.OrderContext do
  @moduledoc """
  The OrderContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.OrderContext.Order
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.OrderContext
      use ApiServer.BaseContext
      alias ApiServer.OrderContext.Order
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(open_id: open_id)
    Order
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "status")
    |> get_pagination(params)
  end

  def page(params) do 
    Order
    |> query_equal(params, "status")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end

end

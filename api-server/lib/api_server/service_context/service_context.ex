defmodule ApiServer.ServiceContext do
  @moduledoc """
  The ServiceContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.ServiceContext.Service

  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.ServiceContext
      use ApiServer.BaseContext
      alias ApiServer.ServiceContext.Service
    end
  end

  def page(params) do 
    Service
    |> query_like(params, "sname")
    |> query_order_by(params, "sname")
    |> get_pagination(params)
  end
end

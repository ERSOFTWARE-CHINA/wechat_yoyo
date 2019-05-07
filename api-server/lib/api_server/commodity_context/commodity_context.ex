defmodule ApiServer.CommodityContext do
  @moduledoc """
  The CommodityContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.CommodityContext.Commodity

  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.CommodityContext
      use ApiServer.BaseContext
      alias ApiServer.CommodityContext.Commodity
    end
  end

  def page(params) do 
    Commodity
    |> query_like(params, "cname")
    |> query_order_by(params, "cname")
    |> get_pagination(params)
  end
end

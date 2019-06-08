defmodule ApiServer.VipCardContext do
  @moduledoc """
  The VipCardContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.VipCardContext.VipCard

  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.VipCardContext
      use ApiServer.BaseContext
      alias ApiServer.VipCardContext.VipCard
    end
  end

  def page(params) do 
    VipCard
    |> query_like(params, "name")
    |> query_order_by(params, "name")
    |> get_pagination(params)
  end
  
end

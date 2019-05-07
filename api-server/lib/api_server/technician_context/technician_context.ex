defmodule ApiServer.TechnicianContext do
  @moduledoc """
  The TechnicianContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.TechnicianContext.Technician

  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.TechnicianContext
      use ApiServer.BaseContext
      alias ApiServer.TechnicianContext.Technician
    end
  end

  def page(params) do 
    Technician
    |> query_like(params, "name")
    |> query_order_by(params, "name")
    |> get_pagination(params)
  end
end

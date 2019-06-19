defmodule ApiServerWeb.ConsumptionRecordController do
  use ApiServerWeb, :controller

  use ApiServer.ConsumptionRecordContext

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, consumption_record} <- get_by_id(ConsumptionRecord, id, [:user]) do
      render(conn, "show.json", consumption_record: consumption_record)
    end
  end

end

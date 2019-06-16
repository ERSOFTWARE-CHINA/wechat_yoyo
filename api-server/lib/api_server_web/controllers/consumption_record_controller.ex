defmodule ApiServerWeb.ConsumptionRecordController do
  use ApiServerWeb, :controller

  alias ApiServer.ConsumptionRecordContext
  alias ApiServer.ConsumptionRecordContext.ConsumptionRecord

  action_fallback ApiServerWeb.FallbackController

  def index(conn, _params) do
    consumption_records = ConsumptionRecordContext.list_consumption_records()
    render(conn, "index.json", consumption_records: consumption_records)
  end

  def create(conn, %{"consumption_record" => consumption_record_params}) do
    with {:ok, %ConsumptionRecord{} = consumption_record} <- ConsumptionRecordContext.create_consumption_record(consumption_record_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.consumption_record_path(conn, :show, consumption_record))
      |> render("show.json", consumption_record: consumption_record)
    end
  end

  def show(conn, %{"id" => id}) do
    consumption_record = ConsumptionRecordContext.get_consumption_record!(id)
    render(conn, "show.json", consumption_record: consumption_record)
  end

  def update(conn, %{"id" => id, "consumption_record" => consumption_record_params}) do
    consumption_record = ConsumptionRecordContext.get_consumption_record!(id)

    with {:ok, %ConsumptionRecord{} = consumption_record} <- ConsumptionRecordContext.update_consumption_record(consumption_record, consumption_record_params) do
      render(conn, "show.json", consumption_record: consumption_record)
    end
  end

  def delete(conn, %{"id" => id}) do
    consumption_record = ConsumptionRecordContext.get_consumption_record!(id)

    with {:ok, %ConsumptionRecord{}} <- ConsumptionRecordContext.delete_consumption_record(consumption_record) do
      send_resp(conn, :no_content, "")
    end
  end
end

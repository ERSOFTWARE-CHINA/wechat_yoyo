defmodule ApiServerWeb.ConsumptionRecordControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.ConsumptionRecordContext
  alias ApiServer.ConsumptionRecordContext.ConsumptionRecord

  @create_attrs %{
    type: "some type"
  }
  @update_attrs %{
    type: "some updated type"
  }
  @invalid_attrs %{type: nil}

  def fixture(:consumption_record) do
    {:ok, consumption_record} = ConsumptionRecordContext.create_consumption_record(@create_attrs)
    consumption_record
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all consumption_records", %{conn: conn} do
      conn = get(conn, Routes.consumption_record_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create consumption_record" do
    test "renders consumption_record when data is valid", %{conn: conn} do
      conn = post(conn, Routes.consumption_record_path(conn, :create), consumption_record: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.consumption_record_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.consumption_record_path(conn, :create), consumption_record: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update consumption_record" do
    setup [:create_consumption_record]

    test "renders consumption_record when data is valid", %{conn: conn, consumption_record: %ConsumptionRecord{id: id} = consumption_record} do
      conn = put(conn, Routes.consumption_record_path(conn, :update, consumption_record), consumption_record: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.consumption_record_path(conn, :show, id))

      assert %{
               "id" => id,
               "type" => "some updated type"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, consumption_record: consumption_record} do
      conn = put(conn, Routes.consumption_record_path(conn, :update, consumption_record), consumption_record: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete consumption_record" do
    setup [:create_consumption_record]

    test "deletes chosen consumption_record", %{conn: conn, consumption_record: consumption_record} do
      conn = delete(conn, Routes.consumption_record_path(conn, :delete, consumption_record))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.consumption_record_path(conn, :show, consumption_record))
      end
    end
  end

  defp create_consumption_record(_) do
    consumption_record = fixture(:consumption_record)
    {:ok, consumption_record: consumption_record}
  end
end

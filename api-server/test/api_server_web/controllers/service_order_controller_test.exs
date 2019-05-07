defmodule ApiServerWeb.ServiceOrderControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.ServiceOrderContext
  alias ApiServer.ServiceOrderContext.ServiceOrder

  @create_attrs %{
    status: "some status"
  }
  @update_attrs %{
    status: "some updated status"
  }
  @invalid_attrs %{status: nil}

  def fixture(:service_order) do
    {:ok, service_order} = ServiceOrderContext.create_service_order(@create_attrs)
    service_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all service_orders", %{conn: conn} do
      conn = get(conn, Routes.service_order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create service_order" do
    test "renders service_order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.service_order_path(conn, :create), service_order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.service_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "some status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.service_order_path(conn, :create), service_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update service_order" do
    setup [:create_service_order]

    test "renders service_order when data is valid", %{conn: conn, service_order: %ServiceOrder{id: id} = service_order} do
      conn = put(conn, Routes.service_order_path(conn, :update, service_order), service_order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.service_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "status" => "some updated status"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, service_order: service_order} do
      conn = put(conn, Routes.service_order_path(conn, :update, service_order), service_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete service_order" do
    setup [:create_service_order]

    test "deletes chosen service_order", %{conn: conn, service_order: service_order} do
      conn = delete(conn, Routes.service_order_path(conn, :delete, service_order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.service_order_path(conn, :show, service_order))
      end
    end
  end

  defp create_service_order(_) do
    service_order = fixture(:service_order)
    {:ok, service_order: service_order}
  end
end

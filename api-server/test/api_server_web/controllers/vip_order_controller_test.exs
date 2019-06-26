defmodule ApiServerWeb.VipOrderControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.VipOrderContext
  alias ApiServer.VipOrderContext.VipOrder

  @create_attrs %{
    vno: "some vno"
  }
  @update_attrs %{
    vno: "some updated vno"
  }
  @invalid_attrs %{vno: nil}

  def fixture(:vip_order) do
    {:ok, vip_order} = VipOrderContext.create_vip_order(@create_attrs)
    vip_order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vip_orders", %{conn: conn} do
      conn = get(conn, Routes.vip_order_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vip_order" do
    test "renders vip_order when data is valid", %{conn: conn} do
      conn = post(conn, Routes.vip_order_path(conn, :create), vip_order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.vip_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "vno" => "some vno"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.vip_order_path(conn, :create), vip_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vip_order" do
    setup [:create_vip_order]

    test "renders vip_order when data is valid", %{conn: conn, vip_order: %VipOrder{id: id} = vip_order} do
      conn = put(conn, Routes.vip_order_path(conn, :update, vip_order), vip_order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.vip_order_path(conn, :show, id))

      assert %{
               "id" => id,
               "vno" => "some updated vno"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, vip_order: vip_order} do
      conn = put(conn, Routes.vip_order_path(conn, :update, vip_order), vip_order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vip_order" do
    setup [:create_vip_order]

    test "deletes chosen vip_order", %{conn: conn, vip_order: vip_order} do
      conn = delete(conn, Routes.vip_order_path(conn, :delete, vip_order))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.vip_order_path(conn, :show, vip_order))
      end
    end
  end

  defp create_vip_order(_) do
    vip_order = fixture(:vip_order)
    {:ok, vip_order: vip_order}
  end
end

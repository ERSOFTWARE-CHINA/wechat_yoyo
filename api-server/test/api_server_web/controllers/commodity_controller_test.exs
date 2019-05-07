defmodule ApiServerWeb.CommodityControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.CommodityContext
  alias ApiServer.CommodityContext.Commodity

  @create_attrs %{
    cname: "some cname"
  }
  @update_attrs %{
    cname: "some updated cname"
  }
  @invalid_attrs %{cname: nil}

  def fixture(:commodity) do
    {:ok, commodity} = CommodityContext.create_commodity(@create_attrs)
    commodity
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all commodities", %{conn: conn} do
      conn = get(conn, Routes.commodity_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create commodity" do
    test "renders commodity when data is valid", %{conn: conn} do
      conn = post(conn, Routes.commodity_path(conn, :create), commodity: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.commodity_path(conn, :show, id))

      assert %{
               "id" => id,
               "cname" => "some cname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.commodity_path(conn, :create), commodity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update commodity" do
    setup [:create_commodity]

    test "renders commodity when data is valid", %{conn: conn, commodity: %Commodity{id: id} = commodity} do
      conn = put(conn, Routes.commodity_path(conn, :update, commodity), commodity: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.commodity_path(conn, :show, id))

      assert %{
               "id" => id,
               "cname" => "some updated cname"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, commodity: commodity} do
      conn = put(conn, Routes.commodity_path(conn, :update, commodity), commodity: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete commodity" do
    setup [:create_commodity]

    test "deletes chosen commodity", %{conn: conn, commodity: commodity} do
      conn = delete(conn, Routes.commodity_path(conn, :delete, commodity))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.commodity_path(conn, :show, commodity))
      end
    end
  end

  defp create_commodity(_) do
    commodity = fixture(:commodity)
    {:ok, commodity: commodity}
  end
end

defmodule ApiServerWeb.VipCardControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.VipCardContext
  alias ApiServer.VipCardContext.VipCard

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:vip_card) do
    {:ok, vip_card} = VipCardContext.create_vip_card(@create_attrs)
    vip_card
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all vip_cards", %{conn: conn} do
      conn = get(conn, Routes.vip_card_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create vip_card" do
    test "renders vip_card when data is valid", %{conn: conn} do
      conn = post(conn, Routes.vip_card_path(conn, :create), vip_card: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.vip_card_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.vip_card_path(conn, :create), vip_card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update vip_card" do
    setup [:create_vip_card]

    test "renders vip_card when data is valid", %{conn: conn, vip_card: %VipCard{id: id} = vip_card} do
      conn = put(conn, Routes.vip_card_path(conn, :update, vip_card), vip_card: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.vip_card_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, vip_card: vip_card} do
      conn = put(conn, Routes.vip_card_path(conn, :update, vip_card), vip_card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete vip_card" do
    setup [:create_vip_card]

    test "deletes chosen vip_card", %{conn: conn, vip_card: vip_card} do
      conn = delete(conn, Routes.vip_card_path(conn, :delete, vip_card))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.vip_card_path(conn, :show, vip_card))
      end
    end
  end

  defp create_vip_card(_) do
    vip_card = fixture(:vip_card)
    {:ok, vip_card: vip_card}
  end
end

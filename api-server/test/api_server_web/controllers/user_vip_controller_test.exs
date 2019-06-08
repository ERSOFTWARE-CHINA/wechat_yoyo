defmodule ApiServerWeb.UserVipControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.UserVipContext
  alias ApiServer.UserVipContext.UserVip

  @create_attrs %{
    remainder: 120.5
  }
  @update_attrs %{
    remainder: 456.7
  }
  @invalid_attrs %{remainder: nil}

  def fixture(:user_vip) do
    {:ok, user_vip} = UserVipContext.create_user_vip(@create_attrs)
    user_vip
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_vip", %{conn: conn} do
      conn = get(conn, Routes.user_vip_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_vip" do
    test "renders user_vip when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_vip_path(conn, :create), user_vip: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_vip_path(conn, :show, id))

      assert %{
               "id" => id,
               "remainder" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_vip_path(conn, :create), user_vip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_vip" do
    setup [:create_user_vip]

    test "renders user_vip when data is valid", %{conn: conn, user_vip: %UserVip{id: id} = user_vip} do
      conn = put(conn, Routes.user_vip_path(conn, :update, user_vip), user_vip: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_vip_path(conn, :show, id))

      assert %{
               "id" => id,
               "remainder" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user_vip: user_vip} do
      conn = put(conn, Routes.user_vip_path(conn, :update, user_vip), user_vip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_vip" do
    setup [:create_user_vip]

    test "deletes chosen user_vip", %{conn: conn, user_vip: user_vip} do
      conn = delete(conn, Routes.user_vip_path(conn, :delete, user_vip))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_vip_path(conn, :show, user_vip))
      end
    end
  end

  defp create_user_vip(_) do
    user_vip = fixture(:user_vip)
    {:ok, user_vip: user_vip}
  end
end

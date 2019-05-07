defmodule ApiServerWeb.TechnicianControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.TechnicianContext
  alias ApiServer.TechnicianContext.Technician

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:technician) do
    {:ok, technician} = TechnicianContext.create_technician(@create_attrs)
    technician
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all technicians", %{conn: conn} do
      conn = get(conn, Routes.technician_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create technician" do
    test "renders technician when data is valid", %{conn: conn} do
      conn = post(conn, Routes.technician_path(conn, :create), technician: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.technician_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.technician_path(conn, :create), technician: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update technician" do
    setup [:create_technician]

    test "renders technician when data is valid", %{conn: conn, technician: %Technician{id: id} = technician} do
      conn = put(conn, Routes.technician_path(conn, :update, technician), technician: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.technician_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, technician: technician} do
      conn = put(conn, Routes.technician_path(conn, :update, technician), technician: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete technician" do
    setup [:create_technician]

    test "deletes chosen technician", %{conn: conn, technician: technician} do
      conn = delete(conn, Routes.technician_path(conn, :delete, technician))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.technician_path(conn, :show, technician))
      end
    end
  end

  defp create_technician(_) do
    technician = fixture(:technician)
    {:ok, technician: technician}
  end
end

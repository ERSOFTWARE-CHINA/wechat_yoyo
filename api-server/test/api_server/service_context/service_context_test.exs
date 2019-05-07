defmodule ApiServer.ServiceContextTest do
  use ApiServer.DataCase

  alias ApiServer.ServiceContext

  describe "services" do
    alias ApiServer.ServiceContext.Service

    @valid_attrs %{sname: "some sname"}
    @update_attrs %{sname: "some updated sname"}
    @invalid_attrs %{sname: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceContext.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert ServiceContext.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert ServiceContext.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = ServiceContext.create_service(@valid_attrs)
      assert service.sname == "some sname"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceContext.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, %Service{} = service} = ServiceContext.update_service(service, @update_attrs)
      assert service.sname == "some updated sname"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = ServiceContext.update_service(service, @invalid_attrs)
      assert service == ServiceContext.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = ServiceContext.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> ServiceContext.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = ServiceContext.change_service(service)
    end
  end
end

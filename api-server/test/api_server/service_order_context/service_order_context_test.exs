defmodule ApiServer.ServiceOrderContextTest do
  use ApiServer.DataCase

  alias ApiServer.ServiceOrderContext

  describe "service_orders" do
    alias ApiServer.ServiceOrderContext.ServiceOrder

    @valid_attrs %{status: "some status"}
    @update_attrs %{status: "some updated status"}
    @invalid_attrs %{status: nil}

    def service_order_fixture(attrs \\ %{}) do
      {:ok, service_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ServiceOrderContext.create_service_order()

      service_order
    end

    test "list_service_orders/0 returns all service_orders" do
      service_order = service_order_fixture()
      assert ServiceOrderContext.list_service_orders() == [service_order]
    end

    test "get_service_order!/1 returns the service_order with given id" do
      service_order = service_order_fixture()
      assert ServiceOrderContext.get_service_order!(service_order.id) == service_order
    end

    test "create_service_order/1 with valid data creates a service_order" do
      assert {:ok, %ServiceOrder{} = service_order} = ServiceOrderContext.create_service_order(@valid_attrs)
      assert service_order.status == "some status"
    end

    test "create_service_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ServiceOrderContext.create_service_order(@invalid_attrs)
    end

    test "update_service_order/2 with valid data updates the service_order" do
      service_order = service_order_fixture()
      assert {:ok, %ServiceOrder{} = service_order} = ServiceOrderContext.update_service_order(service_order, @update_attrs)
      assert service_order.status == "some updated status"
    end

    test "update_service_order/2 with invalid data returns error changeset" do
      service_order = service_order_fixture()
      assert {:error, %Ecto.Changeset{}} = ServiceOrderContext.update_service_order(service_order, @invalid_attrs)
      assert service_order == ServiceOrderContext.get_service_order!(service_order.id)
    end

    test "delete_service_order/1 deletes the service_order" do
      service_order = service_order_fixture()
      assert {:ok, %ServiceOrder{}} = ServiceOrderContext.delete_service_order(service_order)
      assert_raise Ecto.NoResultsError, fn -> ServiceOrderContext.get_service_order!(service_order.id) end
    end

    test "change_service_order/1 returns a service_order changeset" do
      service_order = service_order_fixture()
      assert %Ecto.Changeset{} = ServiceOrderContext.change_service_order(service_order)
    end
  end
end

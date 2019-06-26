defmodule ApiServer.VipOrderContextTest do
  use ApiServer.DataCase

  alias ApiServer.VipOrderContext

  describe "vip_orders" do
    alias ApiServer.VipOrderContext.VipOrder

    @valid_attrs %{vno: "some vno"}
    @update_attrs %{vno: "some updated vno"}
    @invalid_attrs %{vno: nil}

    def vip_order_fixture(attrs \\ %{}) do
      {:ok, vip_order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> VipOrderContext.create_vip_order()

      vip_order
    end

    test "list_vip_orders/0 returns all vip_orders" do
      vip_order = vip_order_fixture()
      assert VipOrderContext.list_vip_orders() == [vip_order]
    end

    test "get_vip_order!/1 returns the vip_order with given id" do
      vip_order = vip_order_fixture()
      assert VipOrderContext.get_vip_order!(vip_order.id) == vip_order
    end

    test "create_vip_order/1 with valid data creates a vip_order" do
      assert {:ok, %VipOrder{} = vip_order} = VipOrderContext.create_vip_order(@valid_attrs)
      assert vip_order.vno == "some vno"
    end

    test "create_vip_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VipOrderContext.create_vip_order(@invalid_attrs)
    end

    test "update_vip_order/2 with valid data updates the vip_order" do
      vip_order = vip_order_fixture()
      assert {:ok, %VipOrder{} = vip_order} = VipOrderContext.update_vip_order(vip_order, @update_attrs)
      assert vip_order.vno == "some updated vno"
    end

    test "update_vip_order/2 with invalid data returns error changeset" do
      vip_order = vip_order_fixture()
      assert {:error, %Ecto.Changeset{}} = VipOrderContext.update_vip_order(vip_order, @invalid_attrs)
      assert vip_order == VipOrderContext.get_vip_order!(vip_order.id)
    end

    test "delete_vip_order/1 deletes the vip_order" do
      vip_order = vip_order_fixture()
      assert {:ok, %VipOrder{}} = VipOrderContext.delete_vip_order(vip_order)
      assert_raise Ecto.NoResultsError, fn -> VipOrderContext.get_vip_order!(vip_order.id) end
    end

    test "change_vip_order/1 returns a vip_order changeset" do
      vip_order = vip_order_fixture()
      assert %Ecto.Changeset{} = VipOrderContext.change_vip_order(vip_order)
    end
  end
end

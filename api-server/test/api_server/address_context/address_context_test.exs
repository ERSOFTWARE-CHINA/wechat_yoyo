defmodule ApiServer.AddressContextTest do
  use ApiServer.DataCase

  alias ApiServer.AddressContext

  describe "addresses" do
    alias ApiServer.AddressContext.Address

    @valid_attrs %{address: "some address"}
    @update_attrs %{address: "some updated address"}
    @invalid_attrs %{address: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AddressContext.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert AddressContext.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert AddressContext.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = AddressContext.create_address(@valid_attrs)
      assert address.address == "some address"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AddressContext.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = AddressContext.update_address(address, @update_attrs)
      assert address.address == "some updated address"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = AddressContext.update_address(address, @invalid_attrs)
      assert address == AddressContext.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = AddressContext.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> AddressContext.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = AddressContext.change_address(address)
    end
  end
end

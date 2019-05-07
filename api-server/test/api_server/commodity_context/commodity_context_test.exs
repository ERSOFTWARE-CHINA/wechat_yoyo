defmodule ApiServer.CommodityContextTest do
  use ApiServer.DataCase

  alias ApiServer.CommodityContext

  describe "commodities" do
    alias ApiServer.CommodityContext.Commodity

    @valid_attrs %{cname: "some cname"}
    @update_attrs %{cname: "some updated cname"}
    @invalid_attrs %{cname: nil}

    def commodity_fixture(attrs \\ %{}) do
      {:ok, commodity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CommodityContext.create_commodity()

      commodity
    end

    test "list_commodities/0 returns all commodities" do
      commodity = commodity_fixture()
      assert CommodityContext.list_commodities() == [commodity]
    end

    test "get_commodity!/1 returns the commodity with given id" do
      commodity = commodity_fixture()
      assert CommodityContext.get_commodity!(commodity.id) == commodity
    end

    test "create_commodity/1 with valid data creates a commodity" do
      assert {:ok, %Commodity{} = commodity} = CommodityContext.create_commodity(@valid_attrs)
      assert commodity.cname == "some cname"
    end

    test "create_commodity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CommodityContext.create_commodity(@invalid_attrs)
    end

    test "update_commodity/2 with valid data updates the commodity" do
      commodity = commodity_fixture()
      assert {:ok, %Commodity{} = commodity} = CommodityContext.update_commodity(commodity, @update_attrs)
      assert commodity.cname == "some updated cname"
    end

    test "update_commodity/2 with invalid data returns error changeset" do
      commodity = commodity_fixture()
      assert {:error, %Ecto.Changeset{}} = CommodityContext.update_commodity(commodity, @invalid_attrs)
      assert commodity == CommodityContext.get_commodity!(commodity.id)
    end

    test "delete_commodity/1 deletes the commodity" do
      commodity = commodity_fixture()
      assert {:ok, %Commodity{}} = CommodityContext.delete_commodity(commodity)
      assert_raise Ecto.NoResultsError, fn -> CommodityContext.get_commodity!(commodity.id) end
    end

    test "change_commodity/1 returns a commodity changeset" do
      commodity = commodity_fixture()
      assert %Ecto.Changeset{} = CommodityContext.change_commodity(commodity)
    end
  end
end

defmodule ApiServer.VipCardContextTest do
  use ApiServer.DataCase

  alias ApiServer.VipCardContext

  describe "vip_cards" do
    alias ApiServer.VipCardContext.VipCard

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def vip_card_fixture(attrs \\ %{}) do
      {:ok, vip_card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> VipCardContext.create_vip_card()

      vip_card
    end

    test "list_vip_cards/0 returns all vip_cards" do
      vip_card = vip_card_fixture()
      assert VipCardContext.list_vip_cards() == [vip_card]
    end

    test "get_vip_card!/1 returns the vip_card with given id" do
      vip_card = vip_card_fixture()
      assert VipCardContext.get_vip_card!(vip_card.id) == vip_card
    end

    test "create_vip_card/1 with valid data creates a vip_card" do
      assert {:ok, %VipCard{} = vip_card} = VipCardContext.create_vip_card(@valid_attrs)
      assert vip_card.name == "some name"
    end

    test "create_vip_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VipCardContext.create_vip_card(@invalid_attrs)
    end

    test "update_vip_card/2 with valid data updates the vip_card" do
      vip_card = vip_card_fixture()
      assert {:ok, %VipCard{} = vip_card} = VipCardContext.update_vip_card(vip_card, @update_attrs)
      assert vip_card.name == "some updated name"
    end

    test "update_vip_card/2 with invalid data returns error changeset" do
      vip_card = vip_card_fixture()
      assert {:error, %Ecto.Changeset{}} = VipCardContext.update_vip_card(vip_card, @invalid_attrs)
      assert vip_card == VipCardContext.get_vip_card!(vip_card.id)
    end

    test "delete_vip_card/1 deletes the vip_card" do
      vip_card = vip_card_fixture()
      assert {:ok, %VipCard{}} = VipCardContext.delete_vip_card(vip_card)
      assert_raise Ecto.NoResultsError, fn -> VipCardContext.get_vip_card!(vip_card.id) end
    end

    test "change_vip_card/1 returns a vip_card changeset" do
      vip_card = vip_card_fixture()
      assert %Ecto.Changeset{} = VipCardContext.change_vip_card(vip_card)
    end
  end
end

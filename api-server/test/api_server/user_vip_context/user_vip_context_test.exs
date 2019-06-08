defmodule ApiServer.UserVipContextTest do
  use ApiServer.DataCase

  alias ApiServer.UserVipContext

  describe "user_vip" do
    alias ApiServer.UserVipContext.UserVip

    @valid_attrs %{remainder: 120.5}
    @update_attrs %{remainder: 456.7}
    @invalid_attrs %{remainder: nil}

    def user_vip_fixture(attrs \\ %{}) do
      {:ok, user_vip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserVipContext.create_user_vip()

      user_vip
    end

    test "list_user_vip/0 returns all user_vip" do
      user_vip = user_vip_fixture()
      assert UserVipContext.list_user_vip() == [user_vip]
    end

    test "get_user_vip!/1 returns the user_vip with given id" do
      user_vip = user_vip_fixture()
      assert UserVipContext.get_user_vip!(user_vip.id) == user_vip
    end

    test "create_user_vip/1 with valid data creates a user_vip" do
      assert {:ok, %UserVip{} = user_vip} = UserVipContext.create_user_vip(@valid_attrs)
      assert user_vip.remainder == 120.5
    end

    test "create_user_vip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserVipContext.create_user_vip(@invalid_attrs)
    end

    test "update_user_vip/2 with valid data updates the user_vip" do
      user_vip = user_vip_fixture()
      assert {:ok, %UserVip{} = user_vip} = UserVipContext.update_user_vip(user_vip, @update_attrs)
      assert user_vip.remainder == 456.7
    end

    test "update_user_vip/2 with invalid data returns error changeset" do
      user_vip = user_vip_fixture()
      assert {:error, %Ecto.Changeset{}} = UserVipContext.update_user_vip(user_vip, @invalid_attrs)
      assert user_vip == UserVipContext.get_user_vip!(user_vip.id)
    end

    test "delete_user_vip/1 deletes the user_vip" do
      user_vip = user_vip_fixture()
      assert {:ok, %UserVip{}} = UserVipContext.delete_user_vip(user_vip)
      assert_raise Ecto.NoResultsError, fn -> UserVipContext.get_user_vip!(user_vip.id) end
    end

    test "change_user_vip/1 returns a user_vip changeset" do
      user_vip = user_vip_fixture()
      assert %Ecto.Changeset{} = UserVipContext.change_user_vip(user_vip)
    end
  end
end

defmodule ApiServer.UserServiceContextTest do
  use ApiServer.DataCase

  alias ApiServer.UserServiceContext

  describe "user_service" do
    alias ApiServer.UserServiceContext.UserService

    @valid_attrs %{times: 42}
    @update_attrs %{times: 43}
    @invalid_attrs %{times: nil}

    def user_service_fixture(attrs \\ %{}) do
      {:ok, user_service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserServiceContext.create_user_service()

      user_service
    end

    test "list_user_service/0 returns all user_service" do
      user_service = user_service_fixture()
      assert UserServiceContext.list_user_service() == [user_service]
    end

    test "get_user_service!/1 returns the user_service with given id" do
      user_service = user_service_fixture()
      assert UserServiceContext.get_user_service!(user_service.id) == user_service
    end

    test "create_user_service/1 with valid data creates a user_service" do
      assert {:ok, %UserService{} = user_service} = UserServiceContext.create_user_service(@valid_attrs)
      assert user_service.times == 42
    end

    test "create_user_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserServiceContext.create_user_service(@invalid_attrs)
    end

    test "update_user_service/2 with valid data updates the user_service" do
      user_service = user_service_fixture()
      assert {:ok, %UserService{} = user_service} = UserServiceContext.update_user_service(user_service, @update_attrs)
      assert user_service.times == 43
    end

    test "update_user_service/2 with invalid data returns error changeset" do
      user_service = user_service_fixture()
      assert {:error, %Ecto.Changeset{}} = UserServiceContext.update_user_service(user_service, @invalid_attrs)
      assert user_service == UserServiceContext.get_user_service!(user_service.id)
    end

    test "delete_user_service/1 deletes the user_service" do
      user_service = user_service_fixture()
      assert {:ok, %UserService{}} = UserServiceContext.delete_user_service(user_service)
      assert_raise Ecto.NoResultsError, fn -> UserServiceContext.get_user_service!(user_service.id) end
    end

    test "change_user_service/1 returns a user_service changeset" do
      user_service = user_service_fixture()
      assert %Ecto.Changeset{} = UserServiceContext.change_user_service(user_service)
    end
  end
end

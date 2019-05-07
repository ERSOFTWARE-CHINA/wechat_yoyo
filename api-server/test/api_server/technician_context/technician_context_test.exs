defmodule ApiServer.TechnicianContextTest do
  use ApiServer.DataCase

  alias ApiServer.TechnicianContext

  describe "technicians" do
    alias ApiServer.TechnicianContext.Technician

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def technician_fixture(attrs \\ %{}) do
      {:ok, technician} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TechnicianContext.create_technician()

      technician
    end

    test "list_technicians/0 returns all technicians" do
      technician = technician_fixture()
      assert TechnicianContext.list_technicians() == [technician]
    end

    test "get_technician!/1 returns the technician with given id" do
      technician = technician_fixture()
      assert TechnicianContext.get_technician!(technician.id) == technician
    end

    test "create_technician/1 with valid data creates a technician" do
      assert {:ok, %Technician{} = technician} = TechnicianContext.create_technician(@valid_attrs)
      assert technician.name == "some name"
    end

    test "create_technician/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TechnicianContext.create_technician(@invalid_attrs)
    end

    test "update_technician/2 with valid data updates the technician" do
      technician = technician_fixture()
      assert {:ok, %Technician{} = technician} = TechnicianContext.update_technician(technician, @update_attrs)
      assert technician.name == "some updated name"
    end

    test "update_technician/2 with invalid data returns error changeset" do
      technician = technician_fixture()
      assert {:error, %Ecto.Changeset{}} = TechnicianContext.update_technician(technician, @invalid_attrs)
      assert technician == TechnicianContext.get_technician!(technician.id)
    end

    test "delete_technician/1 deletes the technician" do
      technician = technician_fixture()
      assert {:ok, %Technician{}} = TechnicianContext.delete_technician(technician)
      assert_raise Ecto.NoResultsError, fn -> TechnicianContext.get_technician!(technician.id) end
    end

    test "change_technician/1 returns a technician changeset" do
      technician = technician_fixture()
      assert %Ecto.Changeset{} = TechnicianContext.change_technician(technician)
    end
  end
end

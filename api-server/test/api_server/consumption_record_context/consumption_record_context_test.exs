defmodule ApiServer.ConsumptionRecordContextTest do
  use ApiServer.DataCase

  alias ApiServer.ConsumptionRecordContext

  describe "consumption_records" do
    alias ApiServer.ConsumptionRecordContext.ConsumptionRecord

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def consumption_record_fixture(attrs \\ %{}) do
      {:ok, consumption_record} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ConsumptionRecordContext.create_consumption_record()

      consumption_record
    end

    test "list_consumption_records/0 returns all consumption_records" do
      consumption_record = consumption_record_fixture()
      assert ConsumptionRecordContext.list_consumption_records() == [consumption_record]
    end

    test "get_consumption_record!/1 returns the consumption_record with given id" do
      consumption_record = consumption_record_fixture()
      assert ConsumptionRecordContext.get_consumption_record!(consumption_record.id) == consumption_record
    end

    test "create_consumption_record/1 with valid data creates a consumption_record" do
      assert {:ok, %ConsumptionRecord{} = consumption_record} = ConsumptionRecordContext.create_consumption_record(@valid_attrs)
      assert consumption_record.type == "some type"
    end

    test "create_consumption_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ConsumptionRecordContext.create_consumption_record(@invalid_attrs)
    end

    test "update_consumption_record/2 with valid data updates the consumption_record" do
      consumption_record = consumption_record_fixture()
      assert {:ok, %ConsumptionRecord{} = consumption_record} = ConsumptionRecordContext.update_consumption_record(consumption_record, @update_attrs)
      assert consumption_record.type == "some updated type"
    end

    test "update_consumption_record/2 with invalid data returns error changeset" do
      consumption_record = consumption_record_fixture()
      assert {:error, %Ecto.Changeset{}} = ConsumptionRecordContext.update_consumption_record(consumption_record, @invalid_attrs)
      assert consumption_record == ConsumptionRecordContext.get_consumption_record!(consumption_record.id)
    end

    test "delete_consumption_record/1 deletes the consumption_record" do
      consumption_record = consumption_record_fixture()
      assert {:ok, %ConsumptionRecord{}} = ConsumptionRecordContext.delete_consumption_record(consumption_record)
      assert_raise Ecto.NoResultsError, fn -> ConsumptionRecordContext.get_consumption_record!(consumption_record.id) end
    end

    test "change_consumption_record/1 returns a consumption_record changeset" do
      consumption_record = consumption_record_fixture()
      assert %Ecto.Changeset{} = ConsumptionRecordContext.change_consumption_record(consumption_record)
    end
  end
end

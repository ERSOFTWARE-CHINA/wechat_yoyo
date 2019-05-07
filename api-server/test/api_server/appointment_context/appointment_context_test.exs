defmodule ApiServer.AppointmentContextTest do
  use ApiServer.DataCase

  alias ApiServer.AppointmentContext

  describe "appointments" do
    alias ApiServer.AppointmentContext.Appointment

    @valid_attrs %{date: "some date"}
    @update_attrs %{date: "some updated date"}
    @invalid_attrs %{date: nil}

    def appointment_fixture(attrs \\ %{}) do
      {:ok, appointment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AppointmentContext.create_appointment()

      appointment
    end

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert AppointmentContext.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert AppointmentContext.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      assert {:ok, %Appointment{} = appointment} = AppointmentContext.create_appointment(@valid_attrs)
      assert appointment.date == "some date"
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AppointmentContext.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{} = appointment} = AppointmentContext.update_appointment(appointment, @update_attrs)
      assert appointment.date == "some updated date"
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = AppointmentContext.update_appointment(appointment, @invalid_attrs)
      assert appointment == AppointmentContext.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = AppointmentContext.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> AppointmentContext.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = AppointmentContext.change_appointment(appointment)
    end
  end
end

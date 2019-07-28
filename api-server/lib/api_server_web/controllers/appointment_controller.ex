defmodule ApiServerWeb.AppointmentController do
  use ApiServerWeb, :controller

  use ApiServer.AppointmentContext
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service
  alias ApiServer.TechnicianContext.Technician
  
  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    user_changeset = get_user_changeset(appointment_params)
    service_changeset = get_service_changeset(appointment_params)
    technician_changeset = get_technician_changeset(appointment_params)
    appointment_changeset = Appointment.changeset(%Appointment{}, appointment_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:service, service_changeset)
    |> Ecto.Changeset.put_assoc(:technician, technician_changeset)
    with {:ok, %Appointment{} = appointment} <- save_create(appointment_changeset) do
      render(conn, "show.json", appointment: appointment)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, appointment} <- get_by_id(Appointment, id, [:service, :technician, :user]) do
      render(conn, "show.json", appointment: appointment)
    end
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    {:ok, appointment} = get_by_id(Appointment, id, [:service, :technician, :user])
    user_changeset = get_user_changeset(appointment_params)
    service_changeset = get_service_changeset(appointment_params)
    technician_changeset = get_technician_changeset(appointment_params)
    appointment_changeset = Appointment.changeset(appointment, appointment_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:service, service_changeset)
    |> Ecto.Changeset.put_assoc(:technician, technician_changeset)
    with {:ok, %Appointment{} = appointment} <- save_update(appointment_changeset) do
      render(conn, "show.json", appointment: appointment)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Appointment{} = appointment} <- delete_by_id(Appointment, id, [:service, :technician, :user]) do
      render(conn, "show.json", appointment: appointment)
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("openid")
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, wechat_openid: open_id) do
          {:error, _} -> nil
          {:ok, user} -> change(User, user)
        end
    end
  end

  defp get_service_changeset(params) do
    params
    |> Map.get("service", %{})
    |> Map.get("id")
    |> case do
      nil -> nil
      id ->
        case get_by_id(Service, id) do
          {:error, _} -> nil
          {:ok, service} -> change(Service, service)
        end
    end
  end


  defp get_technician_changeset(params) do
    params
    |> Map.get("technician", %{})
    |> Map.get("id")
    |> case do
      nil -> nil
      id ->
        case get_by_id(Technician, id) do
          {:error, _} -> nil
          {:ok, technician} -> change(Technician, technician)
        end
    end
  end
end

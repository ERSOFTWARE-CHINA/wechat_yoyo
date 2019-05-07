defmodule ApiServerWeb.TechnicianController do
  use ApiServerWeb, :controller

  use ApiServer.TechnicianContext

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"technician" => technician_params}) do
    technician_changeset = Technician.changeset(%Technician{}, technician_params)
    with {:ok, %Technician{} = technician} <- save_create(technician_changeset) do
      render(conn, "show.json", technician: technician)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, technician} <- get_by_id(Technician, id) do
      render(conn, "show.json", technician: technician)
    end
  end

  def update(conn, %{"id" => id, "technician" => technician_params}) do
    {:ok, technician} = get_by_id(Technician, id)
    technician_changeset = Technician.changeset(technician, technician_params)
    with {:ok, %Technician{} = technician} <- save_update(technician_changeset) do
      render(conn, "show.json", technician: technician)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Technician{} = technician} <- delete_by_id(Technician, id) do
      render(conn, "show.json", technician: technician)
    end
  end
end

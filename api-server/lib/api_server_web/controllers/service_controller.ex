defmodule ApiServerWeb.ServiceController do
  use ApiServerWeb, :controller

  use ApiServer.ServiceContext

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, service_params) do
    service_changeset = Service.changeset(%Service{}, service_params)
    with {:ok, %Service{} = service} <- save_create(service_changeset) do
      render(conn, "show.json", service: service)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, service} <- get_by_id(Service, id) do
      render(conn, "show.json", service: service)
    end
  end

  def update(conn, %{"id" => id} = service_params) do
    {:ok, service} = get_by_id(Service, id)
    service_changeset = Service.changeset(service, service_params)
    with {:ok, %Service{} = service} <- save_update(service_changeset) do
      render(conn, "show.json", service: service)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Service{} = service} <- delete_by_id(Service, id) do
      render(conn, "show.json", service: service)
    end
  end
end

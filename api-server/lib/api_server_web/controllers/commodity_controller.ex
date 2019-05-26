defmodule ApiServerWeb.CommodityController do
  use ApiServerWeb, :controller

  use ApiServer.CommodityContext

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, commodity_params) do
    commodity_changeset = Commodity.changeset(%Commodity{}, commodity_params)
    with {:ok, %Commodity{} = commodity} <- save_create(commodity_changeset) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", commodity: commodity)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, commodity} <- get_by_id(Commodity, id) do
      render(conn, "show.json", commodity: commodity)
    end
  end

  def update(conn, %{"id" => id} = commodity_params) do
    with {:ok, commodity} <- get_by_id(Commodity, id, []) do
      commodity_changeset = Commodity.changeset(commodity, commodity_params)
      with {:ok, %Commodity{} = user} <- save_update(commodity_changeset) do
        render(conn, "show.json", commodity: commodity)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Commodity{} = comodity} <- delete_by_id(Commodity, id) do
      render(conn, "show.json", comodity: comodity)
    end
  end
end

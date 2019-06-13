defmodule ApiServerWeb.OrderController do
  use ApiServerWeb, :controller

  use ApiServer.OrderContext
  alias ApiServer.UserContext.User
  alias ApiServer.CommodityContext.Commodity

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"order" => order_params}) do
    user_changeset = get_user_changeset(order_params)
    commodity_changeset = get_commodity_changeset(order_params)
    order_changeset = Order.changeset(%Order{}, order_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:commodity, commodity_changeset)
    IO.puts inspect order_changeset
    with {:ok, %Order{} = order} <- save_create(order_changeset) do
      render(conn, "show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, order} <- get_by_id(Order, id, [:commodity, :user]) do
      render(conn, "show.json", order: order)
    end
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    {:ok, order} = get_by_id(Order, id, [:commodity, :user])
    user_changeset = get_user_changeset(order_params)
    commodity_changeset = get_commodity_changeset(order_params)
    order_changeset = Order.changeset(order, order_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:commodity, commodity_changeset)
    with {:ok, %Order{} = order} <- save_update(order_changeset) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Order{} = order} <- delete_by_id(Order, id, [:commodity, :user]) do
      render(conn, "show.json", order: order)
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("open_id")
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, open_id: open_id) do
          {:error, _} -> nil
          {:ok, user} -> change(User, user)
        end
    end
  end

  defp get_commodity_changeset(params) do
    params
    |> Map.get("commodity", %{})
    |> Map.get("id")
    |> case do
      nil -> nil
      id ->
        case get_by_id(Commodity, id) do
          {:error, _} -> nil
          {:ok, commodity} -> change(Commodity, commodity)
        end
    end
  end
end

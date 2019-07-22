defmodule ApiServerWeb.ServiceOrderController do
  use ApiServerWeb, :controller

  use ApiServer.ServiceOrderContext
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service
  alias ApiServer.ConsumptionRecordContext.ConsumptionRecord
  import ApiServer.Utils.DatetimeHandler, only: [get_now_str: 0]

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"service_order" => order_params}) do
    user_changeset = get_user_changeset(order_params)
    service_changeset = get_service_changeset(order_params)
    order_changeset = ServiceOrder.changeset(%ServiceOrder{}, order_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:service, service_changeset)
    IO.inspect "################"
    IO.inspect order_changeset
    with {:ok, %ServiceOrder{} = service_order} <- save_create(order_changeset) do
      render(conn, "show.json", service_order: service_order)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, service_order} <- get_by_id(ServiceOrder, id, [:service, :user]) do
      render(conn, "show.json", service_order: service_order)
    end
  end

  def update(conn, %{"id" => id, "service_order" => service_order_params}) do
    {:ok, service_order} = get_by_id(ServiceOrder, id, [:service, :user])
    user_changeset = get_user_changeset(service_order_params)
    service_changeset = get_service_changeset(service_order_params)
    order_changeset = Order.changeset(service_order, service_order_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:service, service_changeset)
    with {:ok, %ServiceOrder{} = service_order} <- save_update(order_changeset) do
      render(conn, "show.json", service_order: service_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %ServiceOrder{} = service_order} <- delete_by_id(ServiceOrder, id, [:service, :user]) do
      render(conn, "show.json", service_order: service_order)
    end
  end

  def pay(conn, %{"id" => id, "service_order" => order_params, "pay_type" => pay_type }) do
    {:ok, service_order} = get_by_id(ServiceOrder, id, [:service, :user])
    case pay_type do
      0 -> # 微信支付
        json conn, %{ok: ""}
      1 -> # 账户
        with {:ok, _} <- pay_by_vip(service_order) do
          json conn, %{ok: "pay success"}
        end
      2 -> # 积分
        json conn, %{error: "not support"}
      _ ->
        json conn, %{error: "pay type error"}
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("wechat_openid")
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
end

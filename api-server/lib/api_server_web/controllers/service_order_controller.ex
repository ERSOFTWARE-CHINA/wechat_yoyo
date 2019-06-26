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

  def create(conn, %{"service_order" => service_order_params, "amount" => amount, "pay_type" => pay_type} ) do
    { user, user_changeset } = get_user_changeset(service_order_params)
    { service, service_changeset } = get_service_changeset(service_order_params)
    consumption_record_changeset = ConsumptionRecord.changeset(%ConsumptionRecord{}, 
      %{
        name: service.sname, 
        type: 2, 
        pay_type: pay_type, 
        amount: service.current_price * amount, 
        datetime: get_now_str
      })
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    order_changeset = ServiceOrder.changeset(%ServiceOrder{}, service_order_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:service, service_changeset)

    with {:ok, _} <- buy_service(
      %{
        user: user, 
        service: service, 
        amount: amount, 
        pay_type: pay_type, 
        changeset: order_changeset
      }),
      {:ok, _} <- save_create(consumption_record_changeset) 
    do
    # render(conn, "show.json", service_order: service_order)
      json conn, %{result: "ok"}
    end
    # end
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

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("wechat_openid")
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, wechat_openid: open_id) do
          {:error, _} -> nil
          {:ok, user} -> {user, change(User, user)}
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
          {:ok, service} -> {service, change(Service, service)}
        end
    end
  end
end

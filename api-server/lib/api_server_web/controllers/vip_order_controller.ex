defmodule ApiServerWeb.VipOrderController do
  use ApiServerWeb, :controller

  use ApiServer.VipOrderContext
  alias ApiServer.VipOrderContext
  alias ApiServer.VipOrderContext.VipOrder
  alias ApiServer.VipCardContext.VipCard
  alias ApiServer.UserContext.User

  action_fallback ApiServerWeb.FallbackController

  def index(conn, _params) do
    vip_orders = VipOrderContext.list_vip_orders()
    render(conn, "index.json", vip_orders: vip_orders)
  end

  # 购买仅生成订单
  def create(conn, %{"vip_order" => vip_order_params}) do
    user_changeset = get_user_changeset(vip_order_params)
    vip_card_changeset = get_vip_card_changeset(vip_order_params)
    order_changeset = VipOrder.changeset(%VipOrder{}, %{})
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    |> Ecto.Changeset.put_assoc(:vip_card, vip_card_changeset)
    with {:ok, %VipOrder{} = order} <- save_create(order_changeset) do
      render(conn, "show.json", vip_order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    vip_order = VipOrderContext.get_vip_order!(id)
    render(conn, "show.json", vip_order: vip_order)
  end

  def update(conn, %{"id" => id, "vip_order" => vip_order_params}) do
    vip_order = VipOrderContext.get_vip_order!(id)

    with {:ok, %VipOrder{} = vip_order} <- VipOrderContext.update_vip_order(vip_order, vip_order_params) do
      render(conn, "show.json", vip_order: vip_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    vip_order = VipOrderContext.get_vip_order!(id)

    with {:ok, %VipOrder{}} <- VipOrderContext.delete_vip_order(vip_order) do
      send_resp(conn, :no_content, "")
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("wechat_openid")
    |> case do
      nil -> nil
      openid ->
        case get_by_name(User, wechat_openid: openid) do
          {:error, _} -> nil
          {:ok, user} -> change(User, user)
        end
    end
  end

  defp get_vip_card_changeset(params) do
    params
    |> Map.get("vip_card", %{})
    |> Map.get("id")
    |> case do
      nil -> nil
      id ->
        case get_by_id(VipCard, id) do
          {:error, _} -> nil
          {:ok, vip_card} -> change(VipCard, vip_card)
        end
    end
  end
end

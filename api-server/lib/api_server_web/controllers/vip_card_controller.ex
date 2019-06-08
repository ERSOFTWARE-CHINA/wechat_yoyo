defmodule ApiServerWeb.VipCardController do
  use ApiServerWeb, :controller

  use ApiServer.VipCardContext
  alias ApiServer.VipCardContext.VipCard

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"vip_card" => vip_card_params}) do
    changeset = VipCard.changeset(%VipCard{}, vip_card_params)
    with {:ok, %VipCard{} = vip_card} <- save_create(changeset) do
      render(conn, "show.json", vip_card: vip_card)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, vip_card} <- get_by_id(VipCard, id) do
      render(conn, "show.json", vip_card: vip_card)
    end
  end

  def update(conn, %{"id" => id, "vip_card" => vip_card_params}) do
    {:ok, vip_card} = get_by_id(VipCard, id)
    changeset = VipCard.changeset(vip_card, vip_card_params)
    with {:ok, %VipCard{} = vip_card} <- save_update(changeset) do
      render(conn, "show.json", vip_card: vip_card)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %VipCard{} = vip_card} <- delete_by_id(VipCard, id) do
      render(conn, "show.json", vip_card: vip_card)
    end
  end
end

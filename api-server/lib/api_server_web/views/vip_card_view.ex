defmodule ApiServerWeb.VipCardView do
  use ApiServerWeb, :view
  alias ApiServerWeb.VipCardView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, VipCardView, "vip_card.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{vip_card: vip_card}) do
    %{data: render_one(vip_card, VipCardView, "vip_card.json")}
  end

  def render("vip_card.json", %{vip_card: vip_card}) do
    %{
      id: vip_card.id,
      name: vip_card.name,
      price: vip_card.price,
      level: vip_card.level,
      swim_price: vip_card.swim_price
    }
  end
end

defmodule ApiServerWeb.UserVipView do
  use ApiServerWeb, :view
  alias ApiServerWeb.UserVipView

  def render("index.json", %{user_vip: user_vip}) do
    %{data: render_many(user_vip, UserVipView, "user_vip.json")}
  end

  def render("show.json", %{user_vip: user_vip}) do
    %{data: render_one(user_vip, UserVipView, "user_vip.json")}
  end

  def render("user_vip.json", %{user_vip: user_vip}) do
    %{
      id: user_vip.id,
      card_id: user_vip.vip_card.name,
      remainder: user_vip.remainder,
    }
  end
end

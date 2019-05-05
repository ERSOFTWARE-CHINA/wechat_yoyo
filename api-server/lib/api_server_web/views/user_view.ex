defmodule ApiServerWeb.UserView do
  use ApiServerWeb, :view
  alias ApiServerWeb.UserView
  import ApiServer.Utils.DropEctoNotLoaded, only: [drop_ecto_not_loaded_from_map: 1]

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, UserView, "user.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      mobile: user.mobile,
      wechat_openid: user.wechat_openid,
      wechat_nickname: user.wechat_nickname,
      wechat_avatar_url: user.wechat_avatar_url,
      is_admin: user.is_admin,
      active: user.active
    }
    |> drop_ecto_not_loaded_from_map
  end
end

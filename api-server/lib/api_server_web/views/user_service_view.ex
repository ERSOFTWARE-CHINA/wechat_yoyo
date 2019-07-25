defmodule ApiServerWeb.UserServiceView do
  use ApiServerWeb, :view
  alias ApiServerWeb.UserServiceView

  def render("index.json", %{user_service: user_service}) do
    %{data: render_many(user_service, UserServiceView, "user_service.json")}
  end

  def render("show.json", %{user_service: user_service}) do
    %{data: render_one(user_service, UserServiceView, "user_service.json")}
  end

  def render("user_service.json", %{user_service: user_service}) do
    %{
      id: user_service.id,
      times: user_service.times,
      sname: user_service.service.sname
    }
  end
end

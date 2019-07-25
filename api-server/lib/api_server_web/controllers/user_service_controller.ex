defmodule ApiServerWeb.UserServiceController do
  use ApiServerWeb, :controller

  use ApiServer.UserServiceContext
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service
  # import ApiServer.Utils.DatetimeHandler, only: [get_now_str: 0]

  action_fallback ApiServerWeb.FallbackController

  def get_all_by_user(conn, %{"openid" => openid}) do
    data = User
    |> get_by_name(wechat_openid: openid)
    |> case do
      {:ok, user} ->
        get_all_buy_user(user.id)
      _ ->
        []
    end
    render(conn, "index.json", user_service: data) 
  end
  
end

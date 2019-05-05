defmodule ApiServerWeb.AuthErrorHandler do
  import Plug.Conn
  import ApiServerWeb.TranslateMsg

  def auth_error(conn, {type, _}, _opts) do
    body = Poison.encode!(%{error: ~t/Invalid token./})
    send_resp(conn, 401, body)
  end
end
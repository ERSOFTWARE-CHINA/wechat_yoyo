defmodule ApiServerWeb.AuthFailureController do
  use ApiServerWeb, :controller
  import ApiServerWeb.TranslateMsg

  def plug_auth_failure(conn, %{"msg" => msg}) do
    json conn , %{error: ~t/#{msg}/}
  end
end
defmodule ApiServerWeb.Plugs.WechatAuth do
  import Plug.Conn

  @auth_url "https://api.weixin.qq.com/sns/auth"
  @wechat_auth_failure "Illegal access"

  def init(default), do: default

  def call(%Plug.Conn{params: %{"access_token" => token, "openid" => openid}} = conn, _default)  do
    HTTPoison.start
    @auth_url <> "?access_token=#{token}&openid=#{openid}"
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Map.get(body, "errmsg") do
          "ok" -> conn
          _ -> conn |> send_resp(403, @wechat_auth_failure)
        end
      {_, _} ->
        conn |> send_resp(403, @wechat_auth_failure)
    end
  end

end
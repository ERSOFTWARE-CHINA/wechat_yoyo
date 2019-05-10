defmodule ApiServerWeb.WechatController do
  use ApiServerWeb, :controller

  @doc """
  微信端第一次访问接口需从这里获取access_token和openid以及其他用户信息
  """
  def get_userinfo(conn, params) do
    IO.inspect Application.get_env(:api_server, ApiServerWeb.WechatController)[:app_id]
    code = Map.get(params, "code")
    get_access_token_url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx2f96d17009ae641b&secret=570467ff0c7bfa03379be800311cf6e2&code=#{code}&grant_type=authorization_code"
    HTTPoison.start
    resp = HTTPoison.get!(get_access_token_url)
    result = Poison.Parser.parse! (resp.body) 

    access_token = Map.get(result, "access_token")
    open_id = Map.get(result, "openid")
    get_userinfo_url = "https://api.weixin.qq.com/sns/userinfo?access_token=#{access_token}&openid=#{open_id}&lang=zh_CN"
    resp = HTTPoison.get!(get_userinfo_url)
    result_userinfo = Poison.Parser.parse! (resp.body) 

    json conn, Map.merge(result, result_userinfo)
  end

  @doc """
  微信支付
  """
  def pay(conn, params) do
    
  end


end

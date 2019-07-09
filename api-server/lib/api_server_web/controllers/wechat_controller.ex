defmodule ApiServerWeb.WechatController do
  use ApiServerWeb, :controller

  alias ApiServer.OrderContext
  alias ApiServer.VipOrderContext
  alias ApiServer.ServiceOrderContext

  @doc """
  微信端第一次访问接口需从这里获取access_token和openid以及其他用户信息
  """
  def get_userinfo(conn, params) do
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
  微信支付成功回调函数,处理由微信端发起的支付结果通知请求
  """
  def paid_callback(conn, %{"openid" => openid, "attach" => product, "out_trade_no" => no} = params) do
    case product do
      "vip_card" ->
        {:ok, _}= VipOrderContext.pay_success(params)
        json conn, %{msg: "success"}
      "service" ->
        json conn, nil
      "commodity" ->
        {:ok, _}= OrderContext.pay_success(params)
        json conn, %{msg: "success"}
      _ ->
        json conn, nil
    end
  end

  @doc """
  微信支付成功回调函数
  """
  def paid_callback(conn, _) do
    json conn, nil
  end

  @doc """
  通知微信
  """
  defp notify_wechat() do
    
  end


end

defmodule ApiServerWeb.VerificationCodeController do
  use ApiServerWeb, :controller

  @doc """
  获取手机号，并返回验证码和发送结果
  """
  def get_code(conn, params) do
    mobile = Map.get(params, "mobile")
    captha = gen_code()
    url = get_url(mobile, Integer.to_string(captha))
    HTTPoison.start
    resp = HTTPoison.get!(url)
    result = 
    XmlToMap.naive_map(resp.body)
    |> Map.get("returnsms")
    |> Map.get("returnstatus")
    json conn, %{code: captha, send_result: result}
  end

  defp gen_code() do
    Enum.random(1000..9999)
  end

  defp get_url(mobile, captcha) do
    url = "https://sh2.ipyy.com/sms.aspx"
    ps = "?action=send&account=jkwl561&password=jkwl56120&mobile=" <> mobile <>"&content=【简迅汽修云】您的" <> "验证码为：" <> captcha
    url <> ps
  end



end

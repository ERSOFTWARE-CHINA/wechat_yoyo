defmodule ApiServer.AddressContext do
  @moduledoc """
  The AddressContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.AddressContext.Address
  alias ApiServer.AddressContext
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.AddressContext
      use ApiServer.BaseContext
      alias ApiServer.AddressContext.Address
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(wechat_openid: open_id)
    Address
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> list_all
  end

  # 设置地址为当前地址
  def set_current(%{"openid" => open_id, "address_id" => address_id}) do
    {:ok, user} = User
    |> get_by_name(wechat_openid: open_id)
    user_id = user.id
    set_current_qry = "UPDATE addresses SET is_current=true WHERE user_id = $1 and id = $2"
    set_not_current_qry = "UPDATE addresses SET is_current=false WHERE user_id = $1 and id != $2"
    Ecto.Adapters.SQL.query!(Repo, set_current_qry, [user_id, address_id])
    Ecto.Adapters.SQL.query!(Repo, set_not_current_qry, [user_id, address_id])
  end

end
defmodule ApiServer.UserVipContext do
  @moduledoc """
  The UserVipContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.UserVipContext.UserVip
  alias ApiServer.UserContext.User
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.UserVipContext
      use ApiServer.BaseContext
      alias ApiServer.UserVipContext.UserVip
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(open_id: open_id)
    UserVip
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> get_pagination(params)
  end

  def page(params) do 
    UserVip
    |> query_order_desc_by(params, "dt")
    |> get_pagination(params)
  end

  def get_by_user(open_id) do
    {:ok, user} = User
    |> get_by_name(open_id: open_id)
    UserVip
    |> get_by_name(user_id: user.id)
    |> case do
      {:ok, user_vip} -> user_vip
      {_, _} -> nil
    end
  end


  
end

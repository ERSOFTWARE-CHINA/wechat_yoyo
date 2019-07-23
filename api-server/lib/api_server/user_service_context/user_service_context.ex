defmodule ApiServer.UserServiceContext do
  @moduledoc """
  The UserServiceContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.UserServiceContext.UserService
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service
  use ApiServer.BaseContext

  # 获取用户所有已购买的服务次数记录
  def get_all_buy_user(user_id) do
    UserService
    |> query_equal(%{"user_id" => user_id}, "user_id")
    |> Repo.all
  end

  # 获取用户购买的特定服务的次数记录
  def get_by_user_and_service(user_id, service_id) do
    UserService
    |> query_equal(%{"user_id" => user_id}, "user_id")
    |> query_equal(%{"service_id" => service_id}, "service_id")
    |> Repo.one
  end

  # 创建一条服务次数记录
  def create(user_id, service_id, times) do
    %UserService{
      user_id: user_id,
      service_id: service_id,
      times: times
    }
    |> Repo.insert
  end



end
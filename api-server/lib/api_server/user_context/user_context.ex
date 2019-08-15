defmodule ApiServer.UserContext do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.UserContext.User
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.UserContext
      use ApiServer.BaseContext
      alias ApiServer.UserContext.User
    end
  end

  def page(params) do 
    User
    |> query_like(params, "name")
    |> query_like(params, "wechat_nickname")
    |> query_like(params, "mobile")
    |> query_equal(params, "active")
    |> query_equal(params, "is_admin")
    |> query_order_by(params, "inserted_at")
    |> get_pagination(params)
  end

  # 根据open_id判断用户是否存在
  def get_by_open_id(open_id) do
    case get_by_name(User, wechat_openid: open_id) do
      {:ok, user} ->
        user
      {_, _} ->
        nil
    end
  end

  # 根据open_id创建新用户
  def insert_by_open_id(open_id) do
    case get_by_open_id(open_id) do
      nil ->
        %User{}
        |> User.changeset(%{wechat_openid: open_id})
        |> Repo.insert()
      _ ->
        {:error, "already exist"}
    end
  end

  # 验证通过返回true，否则返回false
  def validate_username(params) do
    params
    |> Map.get("id", nil)
    |> case do
      nil ->
        name = params
        |> Map.get("name")
        case get_by_name(User, name: name) do
          {:ok, _} -> 
            false
          {:error, _} -> 
            true
        end
      id ->
        User
        |> Repo.get(id)
        |> case do
          nil -> false
          entity ->
            name = params
            |> Map.get("name")
            User
            |> query_equal(params, "name")
            |> query_not_equal(params, "id")
            |> Repo.exists?
            |> case do
              true -> 
                false
              false -> 
                true
            end 
            
        end
    end
  end

end

defmodule ApiServerWeb.UserController do
  use ApiServerWeb, :controller
  use ApiServer.UserContext
  alias ApiServerWeb.Guardian

  import ApiServerWeb.AuthPlugs, only: [auth_enable: 2, auth_admin: 2]

  # plug :auth_admin when action in [:index, :show, :update, :delete]
  # plug :auth_enable when action in [:index, :show, :update, :delete] 

  action_fallback ApiServerWeb.FallbackController

  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, %{"user" => user_params}) do
    user_changeset = User.changeset(%User{}, user_params)
    with {:ok, %User{} = user} <- save_create(user_changeset) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- get_by_id(User, id, []) do
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    with {:ok, user} <- get_by_id(User, id, []) do
      user_changeset = User.changeset(user, user_params)
      with {:ok, %User{} = user} <- save_update(user_changeset) do
        render(conn, "show.json", user: user)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- can_delete(conn, id), {:ok, %User{} = user} <- delete_by_id(User, id) do
      render(conn, "show.json", user: user)
    end
  end

  # 修改密码
  def change_password(conn, %{"old" => old, "new" => new}) do
    {:ok, resource} = ApiServerWeb.Guardian.resource_from_conn(conn)
    case Comeonin.Pbkdf2.checkpw(old, resource.password_hash) do
      false -> json conn, %{error: "password error."}
      true -> 
        user_changeset = User.changeset(resource, %{"password" => new})
        with {:ok, %User{} = user} <- save_update(user_changeset) do
          render(conn, "show.json", user: user)
        end
    end
    
  end

  # 当前登陆用户无法删除
  defp can_delete(conn, user_id) do
    claims = Guardian.Plug.current_claims(conn)
    id = claims["sub"]
    case id == user_id do
      true ->{:error, "can not delete yourself"}
      false ->{:ok, "can delete"}
    end
  end


end

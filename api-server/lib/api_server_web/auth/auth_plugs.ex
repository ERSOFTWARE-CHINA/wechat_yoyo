defmodule ApiServerWeb.AuthPlugs do
  use ApiServerWeb, :controller
  import Plug.Conn

  alias ApiServerWeb.Guardian
  alias ApiServer.Repo

  @cannot_find_user "cannot find user."
  @admin_is_needed "admin is needed."
  @user_is_disabled "user is disabled."

  @api_version "/api/v1/"

  # 验证登陆用户状态可用
  def auth_enable(conn, _) do
    resource = ApiServerWeb.Guardian.Plug.current_resource(conn)
    if is_nil(resource) do
      conn |> redirect(to: "#{@api_version}/plug_auth_failure/#{@cannot_find_user}") |> halt()
    else
      case resource.active do
        true -> conn
        false -> conn |> redirect(to: "#{@api_version}/plug_auth_failure/#{@user_is_disabled}") |> halt()
      end
    end
    
  end

  # 验证登陆用户是否为管理员用户(user.type == true)
  def auth_admin(conn, _) do
    resource = ApiServerWeb.Guardian.Plug.current_resource(conn)
    if is_nil(resource) do
      conn |> redirect(to: "#{@api_version}/plug_auth_failure/#{@cannot_find_user}") |> halt()
    else
      case resource.is_admin do
        true -> conn
        false -> 
          conn |> redirect(to: "#{@api_version}/plug_auth_failure/#{@admin_is_needed}") |> halt()
      end
    end
  end

end
defmodule ApiServerWeb.AddressController do
  use ApiServerWeb, :controller

  use ApiServer.AddressContext
  alias ApiServer.UserContext.User

  action_fallback ApiServerWeb.FallbackController

  # 获取某一用户的地址信息
  def index(conn, params) do
    page = page(params)
    render(conn, "index.json", page: page)
  end

  # 用户创建一个地址
  def create(conn, %{"address" => address_params}) do
    user_changeset = get_user_changeset(address_params)
    address_changeset = Address.changeset(%Address{}, address_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    with {:ok, %Address{} = address} <- save_create(address_changeset) do
      render(conn, "show.json", address: address)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, address} <- get_by_id(Address, id, [:user]) do
      render(conn, "show.json", address: address)
    end
  end

  def current(conn, %{"openid" => openid, "address_id" => address_id} = params) do
    json conn, set_current(params)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    {:ok, address} = get_by_id(Address, id, [:user])
    user_changeset = get_user_changeset(address_params)
    address_changeset = Address.changeset(address, address_params)
    |> Ecto.Changeset.put_assoc(:user, user_changeset)
    with {:ok, %Address{} = address} <- save_update(address_changeset) do
      render(conn, "show.json", address: address)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Address{} = address} <- delete_by_id(Address, id, [:user]) do
      render(conn, "show.json", address: address)
    end
  end

  defp get_user_changeset(params) do
    params
    |> Map.get("user", %{})
    |> Map.get("open_id")
    |> case do
      nil -> nil
      open_id ->
        case get_by_name(User, open_id: open_id) do
          {:error, _} -> nil
          {:ok, user} -> change(User, user)
        end
    end
  end

end

defmodule ApiServer.UserServiceContext.UserService do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service

  schema "user_service" do
    field :times, :integer  #剩余服务次数

    belongs_to :user, User, on_replace: :nilify
    belongs_to :service, Service, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(user_service, attrs) do
    user_service
    |> cast(attrs, [:times, :user_id, :service_id])
    |> validate_required([:times])
  end
end

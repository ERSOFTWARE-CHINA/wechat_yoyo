defmodule ApiServer.ServiceOrderContext.ServiceOrder do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service

  schema "service_orders" do
    field :date, :string
    field :times, :integer #次数
    field :status, :string

    belongs_to :user, User, on_replace: :nilify
    belongs_to :service, Service, on_replace: :nilify
    timestamps()
  end

  @doc false
  def changeset(service_order, attrs) do
    service_order
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end

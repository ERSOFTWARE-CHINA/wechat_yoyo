defmodule ApiServer.AddressContext.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User

  schema "addresses" do
    field :address, :string
    field :is_current, :boolean, default: false
    belongs_to :user, User, on_replace: :nilify
    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:address])
    |> validate_required([:address])
  end
end

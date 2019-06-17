defmodule ApiServer.ServiceContext.Service do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "services" do
    field :sname, :string
    field :times, :integer
    field :original_price, :float
    field :current_price, :float
    field :uuid_01, :string
    field :image_01, ApiServer.ServiceImage.Type
    field :uuid_detail, :string
    field :image_detail, ApiServer.ServiceImageDetail.Type
    field :desc, :string

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:sname, :original_price, :current_price, :desc])
    |> validate_required([:sname])
    |> check_uuid(:uuid_01)
    |> check_uuid(:uuid_detail)
    |> cast_attachments(attrs, [:image_01, :image_detail])
  end

  defp check_uuid(changeset, uuid) do
    case get_field(changeset, uuid) do
      nil ->
        force_change(changeset, uuid, Ecto.UUID.generate)
      _ ->
        changeset
    end
  end
end

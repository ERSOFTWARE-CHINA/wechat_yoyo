defmodule ApiServer.CommodityContext.Commodity do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "commodities" do
    field :cname, :string
    field :original_price, :float
    field :current_price, :float
    field :stock, :float
    field :uuid_01, :string
    field :image_01, ApiServer.CommodityImageOne.Type
    field :uuid_02, :string
    field :image_02, ApiServer.CommodityImageTwo.Type
    field :uuid_03, :string
    field :image_03, ApiServer.CommodityImageThree.Type
    field :uuid_detail, :string
    field :image_detail, ApiServer.CommodityImageDetail.Type
    field :desc, :string

    timestamps()
  end

  @doc false
  def changeset(commodity, attrs) do
    commodity
    |> cast(attrs, [:cname, :original_price, :current_price, :stock, :desc])
    |> validate_required([:cname])
    |> check_uuid(:uuid_01)
    |> check_uuid(:uuid_02)
    |> check_uuid(:uuid_03)
    |> check_uuid(:uuid_detail)
    |> cast_attachments(attrs, [:image_01, :image_02, :image_03, :image_detail])
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

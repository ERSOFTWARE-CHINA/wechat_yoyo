defmodule ApiServer.CommodityContext.Commodity do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "commodities" do
    field :cname, :string
    field :original_price, :float
    field :current_price, :float
    field :stock, :float
    field :image_01, ApiServer.CommodityImage.Type
    field :image_02, ApiServer.CommodityImage.Type
    field :image_03, ApiServer.CommodityImage.Type
    field :image_detail, ApiServer.CommodityImage.Type
    field :desc, :string

    timestamps()
  end

  @doc false
  def changeset(commodity, attrs) do
    commodity
    |> cast(attrs, [:cname, :original_price, :current_price, :stock, :desc])
    |> validate_required([:cname])
    |> check_uuid
    |> cast_attachments(attrs, [:image_01, :image_02, :image_03])
  end

  defp check_uuid(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        force_change(changeset, :uuid, Ecto.UUID.generate)
      _ ->
        changeset
    end
  end
end

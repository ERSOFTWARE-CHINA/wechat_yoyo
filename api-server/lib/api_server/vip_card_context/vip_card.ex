defmodule ApiServer.VipCardContext.VipCard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vip_cards" do
    field :name, :string
    field :price, :float #购买价格
    field :level, :integer #0, 1, 2, ...
    field :value, :float #充值价值
    field :swim_price, :float #游泳优惠价格

    timestamps()
  end

  @doc false
  def changeset(vip_card, attrs) do
    vip_card
    |> cast(attrs, [:name, :price, :level, :value, :swim_price])
    |> validate_required([:name, :level])
  end
end

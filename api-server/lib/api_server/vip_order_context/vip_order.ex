defmodule ApiServer.VipOrderContext.VipOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiServer.VipCardContext.VipCard
  alias ApiServer.UserContext.User
  alias ApiServer.Utils.DatetimeHandler

  schema "vip_orders" do
    field :vno, :string
    field :pay_status, :boolean, default: false # f:未支付，t:已支付
    field :dt, :string
    belongs_to :user, User, on_replace: :nilify 
    belongs_to :vip_card, VipCard, on_replace: :nilify
    timestamps()
  end

  @doc false
  def changeset(vip_order, attrs) do
    vip_order
    |> cast(attrs, [:vno, :pay_status, :dt])
    |> put_vno
    |> put_dt
    |> validate_required([:vno])
  end

  defp put_vno(changeset) do
    if get_field(changeset, :vno) == nil do
      vno = GenServer.call(OrderNoGenerator, :get_vip_order_no)
      force_change(changeset, :vno, vno)
    else
      changeset
    end
  end

  defp put_dt(changeset) do
    if get_field(changeset, :dt) == nil do
      force_change(changeset, :dt, DatetimeHandler.get_now_str)
    else
      changeset
    end
  end
end

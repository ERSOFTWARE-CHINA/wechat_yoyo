defmodule ApiServer.OrderContext.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiServer.UserContext.User
  alias ApiServer.CommodityContext.Commodity
  alias ApiServer.Utils.DatetimeHandler

  schema "orders" do
    field :ono, :string #订单号
    field :amount, :integer #数量
    field :date, :string #订单日期
    field :pickup_type, :boolean, default: true #取货方式 0-自取 1-物流
    field :name, :string #收件人姓名
    field :address, :string #收件人地址
    field :status, :string, default: "a" #订单状态 "a"-已预定，"p"-已支付, “c”-已取消， “d”-已发货
    field :pay_status, :boolean, default: false #f: 未支付；t: 已支付
    field :delivery_info, :string #发货信息
    belongs_to :user, User, on_replace: :nilify 
    belongs_to :commodity, Commodity, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:ono, :amount, :date, :pickup_type, :name, :address, :status, :pay_status, :delivery_info])
    |> put_ono
    |> put_dt
    |> validate_required([:ono])
  end

  defp put_ono(changeset) do
    if get_field(changeset, :ono) == nil do
      force_change(changeset, :ono, GenServer.call(OrderNoGenerator, :get_no))
    else
      changeset
    end
  end

  defp put_dt(changeset) do
    if get_field(changeset, :date) == nil do
      force_change(changeset, :date, DatetimeHandler.get_now_str)
    else
      changeset
    end
  end
end

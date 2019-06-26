defmodule ApiServer.OrderContext.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiServer.UserContext.User
  alias ApiServer.CommodityContext.Commodity

  schema "orders" do
    field :ono, :string #订单号
    field :amount, :float #数量
    field :date, :string #订单日期
    field :pickup_type, :boolean, default: false #取货方式 0-自取 1-物流
    field :name, :string #收件人姓名
    field :address, :string #收件人地址
    field :status, :string #订单状态
    field :pay_status, :boolean, default: false #f: 未支付；t: 已支付
    belongs_to :user, User, on_replace: :nilify 
    belongs_to :commodity, Commodity, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:ono, :amount, :date, :pickup_type, :name, :address, :status])
    |> put_ono
  end

  defp put_ono(changeset) do
    if get_field(changeset, :ono) == nil do
      force_change(changeset, :ono, GenServer.call(OrderNoGenerator, :get_no))
    else
      changeset
    end
  end
end

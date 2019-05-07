defmodule ApiServer.OrderContext.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiServer.UserContext.User

  schema "orders" do
    field :amount, :float #数量
    field :date, :string #订单日期
    field :pickup_type, :boolean, default: false #取货方式 0-自取 1-物流
    field :name, :string #收件人姓名
    field :address, :string #收件人地址
    field :status, :string #订单状态
    belongs_to :user, User, on_replace: :nilify 
    belongs_to :commodity, Commodity, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:amount, :date, :pickup_type, :name, :address, :status])
  end
end

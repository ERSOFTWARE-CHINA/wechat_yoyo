defmodule ApiServer.ConsumptionRecordContext.ConsumptionRecord do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User

  schema "consumption_records" do
    field :name, :string #购买的vip卡、商品或服务的名称
    field :type, :string #消费类型：‘Vip充值’，‘商品’，‘服务’
    field :pay_type, :string #支付类型： ‘微信’，‘优悠账户’，‘积分’
    field :amount, :float #支付金额
    field :datetime, :string #支付时间
    belongs_to :user, User, on_replace: :nilify 

    timestamps()
  end

  @doc false
  def changeset(consumption_record, attrs) do
    consumption_record
    |> cast(attrs, [:name, :type, :pay_type, :amount, :datetime])
    |> validate_required([:name, :type, :pay_type, :amount, :datetime])
  end
end

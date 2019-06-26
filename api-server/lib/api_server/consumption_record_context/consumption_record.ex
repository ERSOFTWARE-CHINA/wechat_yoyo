defmodule ApiServer.ConsumptionRecordContext.ConsumptionRecord do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User

  schema "consumption_records" do
    field :name, :string #购买的vip卡、商品或服务的名称
    field :type, :integer #消费类型：0: ‘Vip充值’，1: ‘商品’，2: ‘服务’
    field :pay_type, :integer #支付类型： 0: ‘微信’，1: ‘优悠账户’，2: ‘积分’
    field :quantity, :integer #购买数量
    field :amount, :float #支付金额
    field :datetime, :string #支付时间
    belongs_to :user, User, on_replace: :nilify 

    timestamps()
  end

  @doc false
  def changeset(consumption_record, attrs) do
    consumption_record
    |> cast(attrs, [:name, :type, :pay_type, :quantity, :amount, :datetime])
    |> validate_required([:name, :type, :pay_type, :quantity, :amount, :datetime])
  end
end

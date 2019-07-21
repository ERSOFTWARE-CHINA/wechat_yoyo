defmodule ApiServer.ServiceOrderContext.ServiceOrder do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User
  alias ApiServer.ServiceContext.Service

  schema "service_orders" do
    field :sno, :string
    field :amount, :integer
    field :date, :string
    field :status, :string, default: "a" #订单状态 "a"-未支付，"p"-已支付, “c”-已取消
    field :pay_status, :boolean, default: false #f: 未支付；t: 已支付

    belongs_to :user, User, on_replace: :nilify
    belongs_to :service, Service, on_replace: :nilify
    timestamps()
  end

  @doc false
  def changeset(service_order, attrs) do
    service_order
    |> cast(attrs, [:sno, :amount, :date, :status, :pay_status])
    |> put_sno
    |> put_dt
    |> validate_required([:status])
  end

  defp put_sno(changeset) do
    if get_field(changeset, :sno) == nil do
      force_change(changeset, :sno, GenServer.call(OrderNoGenerator, :get_service_order_no))
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

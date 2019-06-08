defmodule ApiServer.UserVipContext.UserVip do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiServer.UserContext.User
  alias ApiServer.VipCardContext.VipCard


  schema "user_vip" do
    field :remainder, :float  #余额
    field :dt, :string #购买时间

    belongs_to :user, User, on_replace: :nilify 
    belongs_to :vip_card, VipCard, on_replace: :nilify
    timestamps()
  end

  @doc false
  def changeset(user_vip, attrs) do
    user_vip
    |> cast(attrs, [:remainder, :dt])
    |> validate_required([:remainder])
  end
end

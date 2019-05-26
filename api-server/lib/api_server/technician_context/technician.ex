defmodule ApiServer.TechnicianContext.Technician do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "technicians" do
    field :name, :string
    field :occupation, :string #职业
    field :characteristic, :string #性格，例：开朗、活泼
    field :order_times, :integer #预约次数
    field :works, :integer #作品数目
    field :rank, :float #好评率
    field :uuid, :string
    field :avatar, ApiServer.TechnicianAvatarImage.Type #头像

    timestamps()
  end

  @doc false
  def changeset(technician, attrs) do
    technician
    |> cast(attrs, [:name, :occupation, :characteristic, :order_times, :works, :rank])
    |> validate_required([:name])
    |> check_uuid
    |> cast_attachments(attrs, [:avatar])
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

defmodule ApiServer.UserContext.User do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :full_name, :string
    field :address, :string
    field :password, :string, virtual: true
    # 默认密码"admin123"
    field :password_hash, :string, default: "$pbkdf2-sha512$160000$.0mu4IBJ8tD5cckQhz9tqQ$Iv05hJ49w8WqovfrVUfind8YFt.lrQpj2TNxVuSDXJ0FZHX2YMSl0l8M.FtqYoGdiZDvcTDUp/5xe4/RgkS7FQ"
    field :wechat_openid, :string
    field :wechat_nickname, :string
    field :wechat_avatar_url, :string
    # 用户类型，后台管理用户为T，微信用户为F
    field :is_admin, :boolean, default: false
    field :mobile, :string
    # 状态为T的用户才可以正常访问
    field :active, :boolean, default: true

    field :uuid, :string              # avatar附件父目录名称
    field :avatar, ApiServer.UserAvatarImage.Type
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :full_name, :address, :password, :wechat_openid, :wechat_nickname, :wechat_avatar_url, :is_admin, :mobile, :active, :uuid])
    |> check_uuid
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:is_admin, :active])
    |> put_password_hash
  end

  @doc false
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  defp check_uuid(changeset) do
    if get_field(changeset, :uuid) == nil do
      force_change(changeset, :uuid, Ecto.UUID.generate)
    else
      changeset
    end
  end
end

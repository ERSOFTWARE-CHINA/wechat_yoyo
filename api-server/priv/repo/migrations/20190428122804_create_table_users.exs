defmodule ApiServer.Repo.Migrations.CreateTableUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :full_name, :string
      add :address, :string
      add :password_hash, :string
      add :wechat_openid, :string
      add :wechat_nickname, :string
      add :wechat_avatar_url, :string
      add :is_admin, :Boolean, null: false
      add :mobile, :string
      add :active, :Boolean, null: false
      add :uuid, :string
      add :avatar, :string
      timestamps()
    end
  end
end

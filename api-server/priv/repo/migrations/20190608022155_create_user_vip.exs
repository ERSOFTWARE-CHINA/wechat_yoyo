defmodule ApiServer.Repo.Migrations.CreateUserVip do
  use Ecto.Migration

  def change do
    create table(:user_vip) do
      add :remainder, :float

      timestamps()
    end

  end
end

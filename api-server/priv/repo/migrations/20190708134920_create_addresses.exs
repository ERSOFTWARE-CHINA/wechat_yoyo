defmodule ApiServer.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :address, :string
      add :is_current, :boolean
      add :user_id, references(:users)

      timestamps()
    end

  end
end

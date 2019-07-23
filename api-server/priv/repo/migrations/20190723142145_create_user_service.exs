defmodule ApiServer.Repo.Migrations.CreateUserService do
  use Ecto.Migration

  def change do
    create table(:user_service) do
      add :times, :integer
      add :user_id, references(:users)
      add :service_id, references(:services)

      timestamps()
    end

  end
end

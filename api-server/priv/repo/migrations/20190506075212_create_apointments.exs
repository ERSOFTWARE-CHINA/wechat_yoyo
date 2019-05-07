defmodule ApiServer.Repo.Migrations.CreateApointments do
  use Ecto.Migration

  def change do
    create table(:apointments) do
      add :status, :boolean, default: false, null: false

      timestamps()
    end

  end
end

defmodule ApiServer.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :date, :string
      add :time, :string
      add :status, :string
      add :user_id, references(:users)
      add :technician_id, references(:technicians)
      add :service_id, references(:services)
      timestamps()
    end

  end
end

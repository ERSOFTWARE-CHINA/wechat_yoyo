defmodule ApiServer.Repo.Migrations.CreateServiceOrders do
  use Ecto.Migration

  def change do
    create table(:service_orders) do
      add :date, :string
      add :times, :integer
      add :status, :string

      add :user_id, references(:users)
      add :service_id, references(:services)

      timestamps()
    end

  end
end

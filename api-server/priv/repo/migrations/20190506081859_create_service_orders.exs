defmodule ApiServer.Repo.Migrations.CreateServiceOrders do
  use Ecto.Migration

  def change do
    create table(:service_orders) do
      add :sno, :string
      add :amount, :integer
      add :date, :string
      add :status, :string
      add :pay_status, :boolean

      add :user_id, references(:users)
      add :service_id, references(:services)

      timestamps()
    end

  end
end

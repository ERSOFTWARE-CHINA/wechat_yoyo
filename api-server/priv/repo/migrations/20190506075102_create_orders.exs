defmodule ApiServer.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :ono, :string
      add :amount, :integer
      add :date, :string
      add :pickup_type, :boolean
      add :name, :string
      add :address, :string
      add :status, :string
      add :pay_status, :boolean
      add :delivery_info, :string

      add :user_id, references(:users)
      add :commodity_id, references(:commodities)
      timestamps()
    end

  end
end

defmodule ApiServer.Repo.Migrations.CreateConsumptionRecords do
  use Ecto.Migration

  def change do
    create table(:consumption_records) do
      add :type, :integer
      add :pay_type, :integer
      add :name, :string
      add :quantity, :integer
      add :amount, :float
      add :datetime, :string
      add :user_id, references(:users)

      timestamps()
    end

  end
end

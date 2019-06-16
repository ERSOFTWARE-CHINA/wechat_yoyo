defmodule ApiServer.Repo.Migrations.CreateConsumptionRecords do
  use Ecto.Migration

  def change do
    create table(:consumption_records) do
      add :type, :string
      add :pay_type, :string
      add :name, :string
      add :amount, :float
      add :datetime, :string
      add :user_id, references(:users)

      timestamps()
    end

  end
end

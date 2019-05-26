defmodule ApiServer.Repo.Migrations.CreateTechnicians do
  use Ecto.Migration

  def change do
    create table(:technicians) do
      add :name, :string
      add :occupation, :string
      add :characteristic, :string
      add :order_times, :integer
      add :works, :integer
      add :rank, :float
      add :uuid, :string
      add :avatar, :string
      
      timestamps()
    end

  end
end

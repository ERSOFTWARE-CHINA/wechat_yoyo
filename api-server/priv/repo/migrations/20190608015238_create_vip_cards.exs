defmodule ApiServer.Repo.Migrations.CreateVipCards do
  use Ecto.Migration

  def change do
    create table(:vip_cards) do
      add :name, :string
      add :price, :float
      add :level, :integer
      add :swim_price, :float

      timestamps()
    end

  end
end

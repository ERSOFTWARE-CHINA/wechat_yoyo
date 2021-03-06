defmodule ApiServer.Repo.Migrations.CreateCommodities do
  use Ecto.Migration

  def change do
    create table(:commodities) do
      add :cname, :string
      add :original_price, :float
      add :current_price, :float
      add :stock, :float
      add :uuid_01, :string
      add :image_01, :string
      add :uuid_02, :string
      add :image_02, :string
      add :uuid_03, :string
      add :image_03, :string
      add :uuid_detail, :string
      add :image_detail, :string
      add :desc, :text
      
      timestamps()
    end

  end
end

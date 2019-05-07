defmodule ApiServer.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services) do
      add :sname, :string
      add :original_price, :float
      add :current_price, :float
      add :image_01, :string
      add :image_detail, :string
      add :desc, :text

      timestamps()
    end

  end
end

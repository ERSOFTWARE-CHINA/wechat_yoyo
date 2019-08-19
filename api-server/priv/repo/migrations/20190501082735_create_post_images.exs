defmodule ApiServer.Repo.Migrations.CreatePostImages do
  use Ecto.Migration

  def change do
    create table(:post_images) do
      add :image, :string
      add :uuid, :string
      add :post_id, references(:posts)
      timestamps()
    end
  end
end

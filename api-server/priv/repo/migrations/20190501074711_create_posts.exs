defmodule ApiServer.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :date, :string
      add :good, :integer 
      add :content, :text
      add :technician_id, references(:technicians)
      timestamps()
    end

  end
end

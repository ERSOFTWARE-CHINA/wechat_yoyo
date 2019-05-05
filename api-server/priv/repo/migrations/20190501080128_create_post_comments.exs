defmodule ApiServer.Repo.Migrations.CreatePostComments do
  use Ecto.Migration

  def change do
    create table(:post_comments) do
      add :content, :text
      add :date, :string
      add :user_id, references(:users)
      add :post_id, references(:posts)
      timestamps()
    end

  end
end

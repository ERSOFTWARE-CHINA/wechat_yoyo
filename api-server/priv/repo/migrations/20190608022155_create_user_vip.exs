defmodule ApiServer.Repo.Migrations.CreateUserVip do
  use Ecto.Migration

  def change do
    create table(:user_vip) do
      add :remainder, :float
      add :dt, :string
      add :user_id, references(:users)
      add :vip_card_id, references(:vip_cards)
      timestamps()
    end

  end
end

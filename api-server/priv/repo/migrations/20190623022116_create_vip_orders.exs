defmodule ApiServer.Repo.Migrations.CreateVipOrders do
  use Ecto.Migration

  def change do
    create table(:vip_orders) do
      add :vno, :string
      add :pay_status, :boolean
      add :dt, :string
      
      add :user_id, references(:users)
      add :vip_card_id, references(:vip_cards)

      timestamps()
    end

  end
end

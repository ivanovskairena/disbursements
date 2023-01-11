defmodule DisbursementsApp.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :amount, :decimal #:float
      add :created_at, :naive_datetime
      add :completed_at, :naive_datetime
      add :merchant_id, references(:merchants, on_delete: :nothing)
      add :shopper_id, references(:shoppers, on_delete: :nothing)
      timestamps()
    end

    create index(:orders, [:merchant_id])
    create index(:orders, [:shopper_id])
  end
end

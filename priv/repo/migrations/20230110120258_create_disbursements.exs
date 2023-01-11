defmodule DisbursementsApp.Repo.Migrations.CreateDisbursements do
  use Ecto.Migration

  def change do
    create table(:disbursements) do
      add :year, :integer
      add :week, :integer
      add :amount, :decimal #:float
      add :merchant_id, references(:merchants, on_delete: :nothing)
      add :order_id, references(:orders, on_delete: :nothing)

      timestamps()
    end

    create index(:disbursements, [:merchant_id])
    create index(:disbursements, [:order_id])
  end
end

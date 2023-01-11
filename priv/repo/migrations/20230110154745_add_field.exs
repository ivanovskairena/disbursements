defmodule DisbursementsApp.Repo.Migrations.AddField do
  use Ecto.Migration

  def change do

    alter table(:orders) do
      add :disbursement_id, references(:disbursements, on_delete: :nothing)
    end

    create index(:orders, [:disbursement_id])


  end
end

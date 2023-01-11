defmodule DisbursementsApp.Repo.Migrations.CreateMerchants do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string
      add :email, :string
      add :cif, :string

      timestamps()
    end

  end
end

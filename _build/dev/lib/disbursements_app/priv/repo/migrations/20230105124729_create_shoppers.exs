defmodule DisbursementsApp.Repo.Migrations.CreateShoppers do
  use Ecto.Migration

  def change do
    create table(:shoppers) do
      add :name, :string
      add :email, :string
      add :nif, :string

      timestamps()
    end

  end
end

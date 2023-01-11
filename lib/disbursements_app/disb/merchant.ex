defmodule DisbursementsApp.Disb.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :cif, :string
    field :email, :string
    field :name, :string

    has_many :orders,  DisbursementsApp.Disb.Order

    timestamps()
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [:name, :email, :cif])
    |> validate_required([:name, :email, :cif])

   end
end

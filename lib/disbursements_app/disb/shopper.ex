
defmodule DisbursementsApp.Disb.Shopper do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shoppers" do
    field :email, :string
    field :name, :string
    field :nif, :string

    has_many :orders,  DisbursementsApp.Disb.Order

    timestamps()
  end

  @doc false
  def changeset(shopper, attrs) do
    shopper
    |> cast(attrs, [:name, :email, :nif])
    |> validate_required([:name, :email, :nif])

  end
end

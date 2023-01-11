defmodule DisbursementsApp.Disb.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :amount, :decimal #:float
    field :completed_at, :utc_datetime
    field :created_at, :utc_datetime

    belongs_to :merchant,  DisbursementsApp.Disb.Merchant

    belongs_to :shopper, DisbursementsApp.Disb.Shopper
    belongs_to :disbursement,  DisbursementsApp.Disb.Disbursement

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:amount, :created_at, :completed_at])
    |> validate_required([:amount, :created_at, :completed_at])

  end
end

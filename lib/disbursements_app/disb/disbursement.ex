defmodule DisbursementsApp.Disb.Disbursement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "disbursements" do
    field :amount, :decimal #:float
    field :week, :integer
    field :year, :integer

    belongs_to :merchant,  DisbursementsApp.Disb.Merchant

    has_many :order, DisbursementsApp.Disb.Order


    timestamps()
  end

  @doc false
  def changeset(disbursement, attrs) do
    disbursement
    |> cast(attrs, [:year, :week, :amount, :merchant_id])
    |> validate_required([:year, :week, :amount])
  end
end

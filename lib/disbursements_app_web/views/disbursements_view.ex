defmodule DisbursementsAppWeb.DisbursementsView do
  use DisbursementsAppWeb, :view
  alias DisbursementsAppWeb.DisbursementsView

  def render("index.json", %{disbursement: disbursement}) do
    %{data: render_many(disbursement, DisbursementsView, "disbursements.json")}
  end

  def render("show.json", %{disbursements: disbursements}) do
    %{data: render_one(disbursements, DisbursementsView, "disbursements.json")}
  end

  def render("disbursements.json", %{disbursements: disbursements}) do
    %{id: disbursements.id,
       year: disbursements.year,
       week: disbursements.week,
       merchant_id: disbursements.merchant_id,
       merchant_name: disbursements.merchant.name,
     #  order_id: disbursements.order_id,
      inserted_at: disbursements.inserted_at,
      updated_at: disbursements.updated_at}
  end

  def render("calculate.json", %{disbursements_params: disbursements_params}) do

      for d <- disbursements_params do
        %{
          id: d.id,
          year: d.year,
          week: d.week,
          merchant_id: d.merchant_id,
          merchant_name: d.merchant.name,
          inserted_at: d.inserted_at,
          updated_at: d.updated_at
        }
      end

  end
  def render("list_by_merchant.json", %{disb: disb}) do
    %{

        disbursements:
          for i <- disb do
            %{

                  id: i.id,
                  week: i.week,
                  year: i.year,
                  amount: i.amount,
                  merchant:
                  %{
                    merchant_id: i.merchant.id,
                    merchant_name: i.merchant.name,
                    merchant_email: i.merchant.email,
                    merchant_cif: i.merchant.cif
                  }
            }
          end
    }
  end
end

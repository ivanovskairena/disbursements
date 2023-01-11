defmodule DisbursementsAppWeb.MerchantsView do
  use DisbursementsAppWeb, :view
  alias DisbursementsAppWeb.MerchantsView

  def render("index.json", %{merchant: merchant}) do
    %{data: render_many(merchant, MerchantsView, "merchants.json")}
  end

  def render("show.json", %{merchants: merchants}) do
    %{data: render_one(merchants, MerchantsView, "merchants.json")}
  end

  def render("merchants.json", %{merchants: merchants}) do
    %{
      id: merchants.id,
      name: merchants.name,
      email: merchants.email,
      cif: merchants.cif,

      inserted_at: merchants.inserted_at,
      updated_at: merchants.updated_at
    }
  end
end

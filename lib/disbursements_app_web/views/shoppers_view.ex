defmodule DisbursementsAppWeb.ShoppersView do
  use DisbursementsAppWeb, :view
  alias DisbursementsAppWeb.ShoppersView

  def render("index.json", %{shopper: shopper}) do
    %{data: render_many(shopper, ShoppersView, "shoppers.json")}
  end

  def render("show.json", %{shoppers: shoppers}) do
    %{data: render_one(shoppers, ShoppersView, "shoppers.json")}
  end

  def render("shoppers.json", %{shoppers: shoppers}) do
    %{id: shoppers.id,
      name: shoppers.name,
      email: shoppers.email,
      nif: shoppers.nif,
      inserted_at: shoppers.inserted_at,
      updated_at: shoppers.updated_at}
  end
end

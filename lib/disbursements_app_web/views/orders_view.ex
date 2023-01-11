defmodule DisbursementsAppWeb.OrdersView do
  use DisbursementsAppWeb, :view
  alias DisbursementsAppWeb.OrdersView

  def render("index.json", %{order: order}) do
    %{data: render_many(order, OrdersView, "orders.json")}

  end
  def render("diss.json", %{diss: diss}) do
    %{data: render_many(diss, OrdersView, "list_disb.json")}

  end
  def render("show.json", %{orders: orders}) do
    %{data: render_one(orders, OrdersView, "orders.json")}
  end

  def render("orders.json", %{orders: orders}) do
    %{order_id: orders.id,
      merchant: %{
       merchant_id: orders.merchant.id,
       name: orders.merchant.name,
       email: orders.merchant.email,
       cif: orders.merchant.cif
      },
      shopper: %{
        shopper_id: orders.shopper.id,
        name: orders.shopper.name,
        email: orders.shopper.email,
        nif: orders.shopper.nif
      },
      amount: orders.amount,
      created_at: orders.created_at,
      completed_at: orders.completed_at,
      inserted_at: orders.inserted_at,
      updated_at: orders.updated_at
    }
  end

  def render("list_disb.json", %{orders: orders}) do
    %{order_id: orders.id,
      merchant: %{
       merchant_id: orders.merchant.id,
       name: orders.merchant.name,
       email: orders.merchant.email,
       cif: orders.merchant.cif
      },
      shopper: %{
        shopper_id: orders.shopper.id,
        name: orders.shopper.name,
        email: orders.shopper.email,
        nif: orders.shopper.nif
      },
      amount: orders.amount,
      created_at: orders.created_at,
      completed_at: orders.completed_at,
      inserted_at: orders.inserted_at,
      updated_at: orders.updated_at
    }
  end


end

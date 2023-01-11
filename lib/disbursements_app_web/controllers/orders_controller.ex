defmodule DisbursementsAppWeb.OrdersController do
  use DisbursementsAppWeb, :controller
  use PhoenixSwagger
  # use Ecto.Repo
  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Order
  require Logger

  action_fallback DisbursementsAppWeb.FallbackController

  swagger_path :index do
    get "/api/orders"
    summary "List orders"
    description "List all orders in the database"
    tag "Orders"
    produces "application/json"
    # response(200, "OK", Schema.ref(:Orders))
  end

  def index(conn, _params) do
    order = Disb.list_orders()

    render(conn, "index.json", order: order)

  end

  swagger_path :diss do
    get "/api/diss"
    summary "List disbursements"
    description "List all disbursements"
    tag "Disbursements"
    produces "application/json"

  end


  def diss(conn, _params) do
    diss = Disb.list_diss()
    render(conn, "diss.json", diss: diss)
  end


  def create(conn, %{"orders" => orders_params}) do
    with {:ok, %Order{} = orders} <- Disb.create_order(orders_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.orders_path(conn, :show, orders))
      |> render("show.json", orders: orders)
    end
  end

  def show(conn, %{"id" => id}) do
    orders = Disb.get_order!(id)

    render(conn, "show.json", orders: orders)
  end

  def update(conn, %{"id" => id, "orders" => orders_params}) do
    orders = Disb.get_order!(id)

    with {:ok, %Order{} = orders} <- Disb.update_order(orders, orders_params) do
      render(conn, "show.json", orders: orders)
    end
  end

  def delete(conn, %{"id" => id}) do
    orders = Disb.get_order!(id)

    with {:ok, %Order{}} <- Disb.delete_order(orders) do
      send_resp(conn, :no_content, "")
    end
  end
end

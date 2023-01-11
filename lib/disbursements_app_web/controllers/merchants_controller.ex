defmodule DisbursementsAppWeb.MerchantsController do
  use DisbursementsAppWeb, :controller
  use PhoenixSwagger

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Merchant

  action_fallback DisbursementsAppWeb.FallbackController

  swagger_path :index do
    get "/api/merchants"
    summary "List merchants"
    description "List all merchants in the database"
    tag "Merchants"

  end

  def index(conn, _params) do
    merchant = Disb.list_merchants()
    render(conn, "index.json", merchant: merchant)
  end

  def create(conn, %{"merchants" => merchants_params}) do
    with {:ok, %Merchant{} = merchants} <- Disb.create_merchant(merchants_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.merchants_path(conn, :show, merchants))
      |> render("show.json", merchants: merchants)
    end
  end

  def show(conn, %{"id" => id}) do
    merchants = Disb.get_merchant!(id)
    render(conn, "show.json", merchants: merchants)
  end

  def update(conn, %{"id" => id, "merchants" => merchants_params}) do
    merchants = Disb.get_merchant!(id)

    with {:ok, %Merchant{} = merchants} <- Disb.update_merchant(merchants, merchants_params) do
      render(conn, "show.json", merchants: merchants)
    end
  end

  def delete(conn, %{"id" => id}) do
    merchants = Disb.get_merchant!(id)

    with {:ok, %Merchant{}} <- Disb.delete_merchant(merchants) do
      send_resp(conn, :no_content, "")
    end
  end
end

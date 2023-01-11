defmodule DisbursementsAppWeb.ShoppersController do
  use DisbursementsAppWeb, :controller
  use PhoenixSwagger

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Shopper

  action_fallback DisbursementsAppWeb.FallbackController

  swagger_path :index do
    get "/api/shoppers"
    summary "List shoppers"
    description "List all shoppers in the database"
    tag "Shoppers"
    produces "application/json"
  end

  def index(conn, _params) do
    shopper = Disb.list_shoppers()
    render(conn, "index.json", shopper: shopper)
  end



  def create(conn, %{"shoppers" => shoppers_params}) do
    with {:ok, %Shopper{} = shoppers} <- Disb.create_shopper(shoppers_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shoppers_path(conn, :show, shoppers))
      |> render("show.json", shoppers: shoppers)
    end
  end


  def show(conn, %{"id" => id}) do
    shoppers = Disb.get_shopper!(id)
    render(conn, "show.json", shoppers: shoppers)
  end

  def update(conn, %{"id" => id, "shoppers" => shoppers_params}) do
    shoppers = Disb.get_shopper!(id)

    with {:ok, %Shopper{} = shoppers} <- Disb.update_shopper(shoppers, shoppers_params) do
      render(conn, "show.json", shoppers: shoppers)
    end
  end

  def delete(conn, %{"id" => id}) do
    shoppers = Disb.get_shopper!(id)

    with {:ok, %Shopper{}} <- Disb.delete_shopper(shoppers) do
      send_resp(conn, :no_content, "")
    end
  end
end

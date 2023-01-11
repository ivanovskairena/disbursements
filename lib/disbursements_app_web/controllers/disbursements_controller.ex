defmodule DisbursementsAppWeb.DisbursementsController do
  use DisbursementsAppWeb, :controller
  import Ecto.Query
  use PhoenixSwagger
  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Disbursement
  require Logger

  action_fallback DisbursementsAppWeb.FallbackController

  swagger_path :index do
    get "/api/disbursements"
    summary "List all disbursements"
    description "List all disbursements in the database"
    tag "Disbursements"
    produces "application/json"

  end

  swagger_path :list_by_merchant_week do
    get "/api/disbursements_by_merchant?merchant_id={merchant_id}&week={week}"
    summary "List disbursements by merchant ID and week"
    description "List all disbursements by week and Merchant ID"
    tag "Disbursements"
    produces "application/json"
    parameters do
      merchant_id  :path, :integer, "Merchant ID", required: false
      week :path, :integer, "Week"
    end
  end

  def list_by_merchant_week(conn, %{"merchant_id" => merchant_id, "week" => week} = params) do
      disb = Disb.list_by_merchant_week(params)


      Logger.warn "parammsss === #{inspect disb}"
      render(conn, "list_by_merchant.json", disb: disb)
  end



  def index(conn, _params) do
    disbursement =
      Disb.list_disbursements()
        |> DisbursementsApp.Repo.preload(:merchant)

    render(conn, "index.json", disbursement: disbursement)
  end



  def create(conn, %{"disbursements" => disbursements_params}) do
    with {:ok, %Disbursement{} = disbursements} <- Disb.create_disbursement(disbursements_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.disbursements_path(conn, :show, disbursements))
      |> render("show.json", disbursements: disbursements)
    end
  end


  def show(conn, %{"id" => id}) do
    disbursements = Disb.get_disbursement!(id)
    render(conn, "show.json", disbursements: disbursements)
  end

  def update(conn, %{"id" => id, "disbursements" => disbursements_params}) do
    disbursements = Disb.get_disbursement!(id)

    with {:ok, %Disbursement{} = disbursements} <- Disb.update_disbursement(disbursements, disbursements_params) do
      render(conn, "show.json", disbursements: disbursements)
    end
  end

  def delete(conn, %{"id" => id}) do
    disbursements = Disb.get_disbursement!(id)

    with {:ok, %Disbursement{}} <- Disb.delete_disbursement(disbursements) do
      send_resp(conn, :no_content, "")
    end
  end

  def calculate(conn, disbursements_params) do


    last_week =
      Timex.shift(Timex.today(), weeks: -1)


    start_last_week =
      Timex.beginning_of_week(last_week)

    end_last_week =
      Timex.end_of_week(last_week)


    start_f = ~D[2018-02-01]

    end_f =  ~D[2018-03-07]



    {year, week} =
      Timex.iso_week(start_last_week)


    list_all_orders =
       DisbursementsApp.Disb.Order
        |> where([o], not(is_nil(o.completed_at)) )
        |> where([o], fragment("?::date", o.completed_at) >= ^start_f and  fragment("?::date", o.completed_at) <= ^end_f )
        |> DisbursementsApp.Repo.all()


    new_list =
      for am <- list_all_orders do
        %{
          fee: calc_amount(am.amount),
          merchant_id: am.merchant_id,
          amount: am.amount,
          completed_at: am.completed_at
        }
      end

    group_by_merchant =
      Enum.group_by(new_list, fn x -> x.merchant_id end)

    grouped =
      Enum.map(group_by_merchant, fn {x, m} ->

        fees_for_merchant =
          Enum.map(m, fn x -> x.fee end)

        sum =
          Enum.reduce(fees_for_merchant, fn x, acc -> Decimal.add( x , acc) end)

        %{
          merchant_id: x,
          amount: sum
        }

      end)


      for t <- grouped do
        Disb.create_disbursement(%{amount: t.amount, merchant_id: t.merchant_id, year: year, week: week})
      end

     render(conn, "calculate.json", disbursements_params: disbursements_params)
  end

  def calc_amount(amount) do

    first =
      Decimal.new(Decimal.from_float(1/100))

    second =
      Decimal.new(Decimal.from_float(0.95/100))

    third =
      Decimal.new(Decimal.from_float(0.85/100))

    cond do
      Decimal.compare(amount, 50) == :lt ->
        Decimal.mult(amount, first) |> Decimal.round(2)

      Decimal.compare(amount, 300) == :gt ->
        Decimal.mult(amount, second) |> Decimal.round(2)

      Decimal.compare(amount, 50) in [:eq, :gt] and Decimal.compare(amount, 300) in [:eq, :lt] ->
        Decimal.mult(amount, third) |> Decimal.round(2)

    end


  end

end

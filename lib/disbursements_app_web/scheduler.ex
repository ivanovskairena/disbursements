defmodule DisbursementsAppWeb.Scheduler do

  use Quantum, otp_app: :disbursements_app

  import Ecto.Query
  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Disbursement
  require Logger


  def calculate() do

    last_week =
      Timex.shift(Timex.today(), weeks: -1)


    start_last_week =
      Timex.beginning_of_week(last_week)

    end_last_week =
      Timex.end_of_week(last_week)


    start_f = ~D[2018-02-01]

    end_f =  ~D[2018-02-07]


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


      DisbursementsApp.Repo.transaction(fn ->

        for t <- grouped do

          Disb.create_disbursement(%{amount: t.amount, merchant_id: t.merchant_id, year: year, week: week})

        end

      end)



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

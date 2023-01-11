# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DisbursementsApp.Repo.insert!(%DisbursementsApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


shoppers =
File.read!("./json/shoppers.json")
|> Poison.decode!()
|> Enum.map(fn m ->
  %{
    email: m["email"],
    name: m["name"],
    nif: m["nif"],
    inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
    updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  }
end)

DisbursementsApp.Repo.insert_all(DisbursementsApp.Disb.Shopper, shoppers)


merchants =
  File.read!("./json/merchants.json")
  |> Poison.decode!()
  |> Enum.map(fn m ->
    %{
      email: m["email"],
      name: m["name"],
      cif: m["cif"],
      inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
      updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    }
  end)


DisbursementsApp.Repo.insert_all(DisbursementsApp.Disb.Merchant, merchants)


orders =
  File.read!("./json/orders.json")
  |> Poison.decode!()
  |> Enum.map(fn m ->

    {fl, _p} = Float.parse(m["amount"])

    %{
      merchant_id: String.to_integer(m["merchant_id"]),
      shopper_id: String.to_integer( m["shopper_id"]),
      amount: Decimal.new(m["amount"]),
      completed_at: if String.length(m["completed_at"]) > 0 do Timex.parse!(m["completed_at"], "%d/%m/%Y %H:%M:%S", :strftime ) |> Timex.to_datetime()  end,
      created_at: if String.length(m["created_at"]) > 0 do Timex.parse!(m["created_at"], "%d/%m/%Y %H:%M:%S", :strftime ) |> Timex.to_datetime()  end,
      inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
      updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    }
  end)

  DisbursementsApp.Repo.insert_all(DisbursementsApp.Disb.Order, orders)

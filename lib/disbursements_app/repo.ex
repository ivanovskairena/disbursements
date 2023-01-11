defmodule DisbursementsApp.Repo do
  use Ecto.Repo,
    otp_app: :disbursements_app,
    adapter: Ecto.Adapters.Postgres
end

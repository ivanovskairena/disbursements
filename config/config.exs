# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :disbursements_app,
  ecto_repos: [DisbursementsApp.Repo]

# Configures the endpoint
config :disbursements_app, DisbursementsAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4kErBdFgWZ/XC4rSaYX8Mem7Yl6B8VEXmlgztk/twcs15H+16GugxgH5xzZLhLHJ",
  render_errors: [view: DisbursementsAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DisbursementsApp.PubSub,
  live_view: [signing_salt: "AZtqT0eM"],
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg|json)$},
      ~r{priv/gettext/.*(po)$}
    ]
  ],
 reloadable_compilers: [:gettext, :phoenix, :elixir, :phoenix_swagger]
# Configures Elixir's Logger
config :phoenix_swagger, json_library: Jason

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
#config :phoenix, :json_library, Jason


config :disbursements_app, DisbursementsAppWeb.Scheduler,
  jobs: [
    # Every monday
    {"0 0 * * MON",   {DisbursementsAppWeb.Scheduler, :calculate, []}},

  ]


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :disbursements_app, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: DisbursementsAppWeb.Router,
      endpoint: DisbursementsAppWeb.Endpoint
    ]
  }

defmodule DisbursementsAppWeb.Router do
  use DisbursementsAppWeb, :router

  pipeline :browser do
    # plug :accepts, ["html"]
    plug :accepts, ["html", "json", "xml", "application/xml"]
    plug :put_root_layout, {DisbursementsAppWeb.LayoutView, "root.html"}
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    #plug Phoenix.LiveView.Flash
    plug :fetch_live_flash

  end

  pipeline :api do
    plug :accepts, ["json", "application/xml"]
  end

  scope "/api", DisbursementsAppWeb do
    pipe_through :api



    resources "/merchants", MerchantsController, except: [:new, :edit]
    resources "/shoppers", ShoppersController, except: [:new, :edit]
    resources "/orders", OrdersController, except: [:new, :edit]
    resources "/disbursements", DisbursementsController, except: [:new, :edit]

    get "/disbursements_by_merchant", DisbursementsController, :list_by_merchant_week

  end

  def swagger_info do
    %{
      schemes: ["http", "https", "ws", "wss"],
      info: %{
        version: "1.0",
        title: "DisbursementsAPI",
        description: "API Documentation for Disbursements API v1",
        contact: %{
          name: "Irena Ivanovska",
          email: "irena@digitalpoint.mk"

        }
      },
      consumes: ["application/json"],
      produces: ["application/json"],

    }
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :disbursements_app, swagger_file: "swagger.json"
  end

  scope "/", DisbursementsAppWeb do


    pipe_through :browser

    live "/", PageLive, :index

    get "/calculate", DisbursementsController, :calculate

    live "/merchants", MerchantLive.Index, :index
    live "/merchants/new", MerchantLive.Index, :new
    live "/merchants/:id/edit", MerchantLive.Index, :edit
    live "/merchants/:id", MerchantLive.Show, :show

    live "/shoppers", ShopperLive.Index, :index
    live "/shoppers/new", ShopperLive.Index, :new
    live "/shoppers/:id/edit", ShopperLive.Index, :edit
    live "/shoppers/:id", ShopperLive.Show, :show


    live "/orders", OrderLive.Index, :index
    live "/orders/new", OrderLive.Index, :new
    live "/orders/:id/edit", OrderLive.Index, :edit
    live "/orders/:id", OrderLive.Show, :show



    live "/disbursements", DisbursementLive.Index, :index
    live "/disbursements/new", DisbursementLive.Index, :new
    live "/disbursements/:id/edit", DisbursementLive.Index, :edit
    live "/disbursements/:id", DisbursementLive.Show, :show

  end

  # Other scopes may use custom stacks.
  scope "/api", DisbursementsAppWeb do
    pipe_through :api
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DisbursementsAppWeb.Telemetry
    end
  end
end

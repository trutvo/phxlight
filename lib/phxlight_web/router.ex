defmodule PhxlightWeb.Router do
  use PhxlightWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhxlightWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope PhxlightWeb.get_root_path() <> "/", PhxlightWeb do
    pipe_through :browser

    live "/", LightTopicLive
    get "/home", PageController, :index

    live "/clock", ClockLive
    live "/light", LightLive
    live "/light_topic", LightTopicLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxlightWeb do
  #   pipe_through :api
  # end

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

      live_dashboard "/dashboard", metrics: PhxlightWeb.Telemetry
    end
  end
end

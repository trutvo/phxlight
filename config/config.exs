# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

root_path = System.get_env("ROOT_PATH", "/")

config :phxlight,
 root_path: root_path


# Configures the endpoint
config :phxlight, PhxlightWeb.Endpoint,
  url: [host: "localhost", path: root_path],
  render_errors: [view: PhxlightWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Phxlight.PubSub,
  live_view: [signing_salt: "8JQ11oHx"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

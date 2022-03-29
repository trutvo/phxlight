import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phxlight, PhxlightWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: System.get_env("PORT") || 4002],
  secret_key_base: "hiSpxwaDcWowVhuDAJAX46cFHFnYR/EG7mJspggfoYsgwKj+oIcGkot6g7kX0vWu",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

defmodule Phxlight.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  defp get_env_as_integer(name, default_value) do
    value = System.get_env(name, "")
    case Integer.parse(value) do
      { num, _ } -> num
      _ -> default_value
    end
  end

  defp get_pubsub() do
    redis_host = System.get_env("REDIS_HOST")
    node_name = System.get_env("NODE_NAME", UUID.uuid1())
    redis_port = get_env_as_integer("REDIS_PORT", 6379)
    if Blankable.blank?(redis_host) do
      {Phoenix.PubSub, name: Phxlight.PubSub}
    else
      Logger.info("Activate PubSub.Redis on host #{redis_host}:#{redis_port} for node '#{node_name}'")
      {Phoenix.PubSub,
        adapter: Phoenix.PubSub.Redis,
        name: Phxlight.PubSub,
        host: redis_host,
        port: redis_port,
        node_name: node_name}
    end
  end

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxlightWeb.Telemetry,
      # Start the PubSub system
      get_pubsub(),
      # Start the Endpoint (http/https)
      PhxlightWeb.Endpoint
      # Start a worker by calling: Phxlight.Worker.start_link(arg)
      # {Phxlight.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phxlight.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxlightWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

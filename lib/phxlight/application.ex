defmodule Phxlight.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxlightWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phxlight.PubSub},
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

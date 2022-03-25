

defmodule PhxlightWeb.ClockLive do
  use PhxlightWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = assign_current_time(socket)
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1><%= @now %></h1>
    """
  end

  @impl true
  def handle_info(:tick, socket) do
    socket = assign_current_time(socket)

    {:noreply, socket}
  end

  def assign_current_time(socket) do
    now =
      Time.utc_now()
      |> Time.to_string()
      |> String.split(".")
      |> hd

    assign(socket, now: now)
  end
end

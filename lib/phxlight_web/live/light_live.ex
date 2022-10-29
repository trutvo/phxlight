defmodule PhxlightWeb.LightLive do
  use PhxlightWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> set_light_status("off")

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>The light is <%= @light_bulb_status %>.</h1>
    <p><img src={@image_path} alt="Phoenix Framework Logo"/></p>
    <%= if @light_bulb_status == "off" do %>
      <button phx-click="on">On</button>
    <% else %>
      <button phx-click="off">Off</button>
    <% end %>
    """
  end

  @impl true
  def handle_event("on", _value, socket) do
    socket =
      socket
      |> set_light_status("on")

    {:noreply, socket}
  end

  @impl true
  def handle_event("off", _value, socket) do
    socket =
      socket
      |> set_light_status("off")

    {:noreply, socket}
  end

  defp set_light_status(socket, status) do
    socket
    |> assign(:light_bulb_status, status)
    |> assign(:image_path, PhxlightWeb.get_path("/images/light-#{status}.jpg"))
  end

end

defmodule PhxlightWeb.LightTopicLive do
  use PhxlightWeb, :live_view

  @topic "light-topic"

  def mount(_params, _session, socket) do
    PhxlightWeb.Endpoint.subscribe(@topic)
    socket =
      socket
      |> set_light_status("off")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>The light is <%= @light_bulb_status %>.</h1>
    <p><b>Plase open this example in two different browsers!</b></p>
    <p><img src={@image_path} alt="Phoenix Framework Logo"/></p>
    <%= if @light_bulb_status == "off" do %>
      <button phx-click="on">On</button>
    <% else %>
      <button phx-click="off">Off</button>
    <% end %>
    """
  end

  def handle_event("on", _value, socket) do
    PhxlightWeb.Endpoint.broadcast_from(self(), @topic, "update-light-status-event", "on")
    socket =
      socket
      |> set_light_status("on")

    {:noreply, socket}
  end

  def handle_event("off", _value, socket) do
    PhxlightWeb.Endpoint.broadcast_from(self(), @topic, "update-light-status-event", "off")
    socket =
      socket
      |> set_light_status("off")

    {:noreply, socket}
  end

  def handle_info(%{topic: @topic, payload: status}, socket) do
    {:noreply, set_light_status(socket, status)}
  end

  defp set_light_status(socket, status) do
    socket
    |> assign(:light_bulb_status, status)
    |> assign(:image_path, "/images/light-#{status}.jpg")
  end
end

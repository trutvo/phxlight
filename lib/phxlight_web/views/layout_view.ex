defmodule PhxlightWeb.LayoutView do
  use PhxlightWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def  root_path_meta_tag() do
    tag(:meta, [name: "root-path", content: PhxlightWeb.get_root_path()])
  end
end

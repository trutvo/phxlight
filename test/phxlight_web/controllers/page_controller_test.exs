defmodule PhxlightWeb.PageControllerTest do
  use PhxlightWeb.ConnCase

  test "GET /home", %{conn: conn} do
    conn = get(conn, "/home")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end

defmodule PreventWeb.MainController do
  use PreventWeb, :controller

  def login(conn, _params) do
    render(conn, "patient.html")
  end
end

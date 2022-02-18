defmodule PreventWeb.CalendarController do
  use PreventWeb, :controller

  def index(conn, _params) do
    render(conn, "calendar.html")
  end
end

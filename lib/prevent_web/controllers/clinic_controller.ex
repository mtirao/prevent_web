defmodule PreventWeb.ClinicController do
  use PreventWeb, :controller

  def index(conn, _params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)
    render(conn, "clinic.html")
  end

  def detail(conn, _params) do
    render(conn, "detail.html")
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end
end

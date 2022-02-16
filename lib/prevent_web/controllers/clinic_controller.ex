defmodule PreventWeb.ClinicController do
  use PreventWeb, :controller

  def index(conn, _params) do
    render(conn, "clinic.html")
  end

  def detail(conn, _params) do
    render(conn, "detail.html")
  end
end

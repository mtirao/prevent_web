defmodule PreventWeb.PageController do
  use PreventWeb, :controller

  def index(conn, _params) do
    token = get_csrf_token()
    render(conn, "index.html", csrf_token: token)
  end
end

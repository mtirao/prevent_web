defmodule PreventWeb.ClinicController do
  use PreventWeb, :controller

  def index(conn, _params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)

    url = "http://localhost:3200/api/prevent/adults"
    headers = [{"Content-type", "application/json"}]
    response = HTTPoison.post!(url, "", headers, [])


    if response.status_code == 200 do
      adults = Jason.decode!(response.body)

      if length(adults) > 0 do
        render(conn, "clinic.html", clinic: adults)
      else
        render(conn, "new.html")
      end
    end

    render(conn, "new.html")
  end

  def detail(conn, _params) do
    render(conn, "detail.html")
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end
end

defmodule PreventWeb.MainController do
  use PreventWeb, :controller


  def index(conn, _params) do
    token = get_csrf_token()

    render(conn, "index.html", csrf_token: token, error_message: "")
  end

  def login(conn, params) do

    url = "http://localhost:3000/api/prevent/accounts/login"
    headers = [{"Content-type", "application/json"}]
    response = HTTPoison.post!(url, Jason.encode!(%{"username" => params["username"],  "password" => params["password"]}), headers, [])


    if response.status_code == 200 do
      profile = Jason.decode!(response.body)
      firstname = profile["firstname"]
      lastname = profile["lastname"]
      conn = put_session(conn, :userid, profile["profileid"])
      conn = put_session(conn, :username, "#{firstname} #{lastname}")

      patientsList = Enum.map(patients(), fn x -> patient_map(x) end)

      patients =  patientsList |> Enum.with_index

      render(conn, "patient.html", name: "#{firstname} #{lastname}", patients: patients , val: 0)
    else
      token = get_csrf_token()
      render(conn, "index.html", error_message: "User or password incorrect",  csrf_token: token)
    end
  end

  def patient_map(patient) do
    {:ok, value} = DateTimeParser.parse(patient["birthday"])
    age = trunc(NaiveDateTime.diff(NaiveDateTime.utc_now, value) / 31536000)
    id = patient["profileid"]
    patientid = patient["patientid"]

    patient |> Map.put("age", age)
            |> Map.put("profileid", id)
            |> Map.put("patientid", patientid)
  end

  def home(conn, _params) do
    patientsList = Enum.map(patients(), fn x -> patient_map(x) end)

    patients =  patientsList |> Enum.with_index

    render(conn, "patient.html", name: "", patients: patients , val: 0)
  end


  def patients do
    headers = [{"Content-type", "application/json"}]
    url = "http://localhost:3000/api/prevent/patients"
    response = HTTPoison.get!(url, headers)
    if response.status_code == 200 do
      Jason.decode!(response.body)
    else
      []
    end
  end

end

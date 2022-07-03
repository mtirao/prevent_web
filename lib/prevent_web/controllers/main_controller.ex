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
      conn = put_session(conn, :userrole, profile["userrole"])


      patientsList = Enum.map(Helper.patients(), fn x -> patient_map(x) end)

      patients =  patientsList |> Enum.with_index

      render(conn, "patient.html", name: "#{firstname} #{lastname}", patients: patients , val: 0, userrole: profile["userrole"])
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

  def doctor_map(doctor) do
    id = doctor["profileid"]
    doctorid = doctor["doctorid"]

    doctor |> Map.put("profileid", id)
            |> Map.put("doctorid", doctorid)
  end


  def home(conn, _params) do
    patientsList = Enum.map(Helper.patients(), fn x -> patient_map(x) end)

    patients =  patientsList |> Enum.with_index


    render(conn, "patient.html", name: "", patients: patients , val: 0, userrole: get_session(conn, :userrole))
  end

  def home_doctor(conn, _params) do

    doctorList = Enum.map(doctors(), fn x -> doctor_map(x) end)

    render(conn, "doctor.html", doctors: doctorList |> Enum.with_index, userrole: get_session(conn, :userrole))

  end

  def home_hospital(conn, _params) do

   # hospitalList = Enum.map(hospitals(), fn x -> hospital_map(x) end)

    hospitalList = hospitals()

    render(conn, "hospital.html", hospitals: hospitalList |> Enum.with_index, userrole: get_session(conn, :userrole))

  end

  def home_calendar_doctor(conn, _params) do

    doctorList = Enum.map(doctors(), fn x -> doctor_map(x) end)

    render(conn, "calendar_doctor.html", doctors: doctorList |> Enum.with_index, userrole: get_session(conn, :userrole))

  end

  def home_calendar_doctor_new(conn, _params) do

    doctorList = Enum.map(doctors(), fn x -> doctor_map(x) end)

    render(conn, "calendar_doctor_new.html", doctors: doctorList |> Enum.with_index, userrole: get_session(conn, :userrole))

  end

  def home_calendar_realm_new(conn, _params) do

    realmList = Enum.map(doctors(), fn x -> doctor_map(x) end)

    render(conn, "calendar_realm_new.html", realms: realmList |> Enum.with_index, userrole: get_session(conn, :userrole))

  end


  def doctors do
    headers = [{"Content-type", "application/json"}]
    url = "http://localhost:3000/api/prevent/doctors"
    response = HTTPoison.get!(url, headers)
    if response.status_code == 200 do
      IO.puts(response.body)
      Jason.decode!(response.body)
    else
      []
    end
  end

  def hospitals do
    headers = [{"Content-type", "application/json"}]
    url = "http://localhost:3100/api/prevent/hospitals"
    response = HTTPoison.get!(url, headers)
    if response.status_code == 200 do
      IO.puts(response.body)
      Jason.decode!(response.body)
    else
      []
    end
  end

  def realms do
    headers = [{"Content-type", "application/json"}]
    url = "http://localhost:3100/api/prevent/hospitals"
    response = HTTPoison.get!(url, headers)
    if response.status_code == 200 do
      IO.puts(response.body)
      Jason.decode!(response.body)
    else
      []
    end
  end


end

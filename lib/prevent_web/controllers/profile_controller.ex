defmodule PreventWeb.ProfileController do
  use PreventWeb, :controller

  def index(conn, _params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)

    render(conn, "clinic.html", userrole: get_session(conn, :userrole))
  end

  def detail_patient(conn, _params) do
    render(conn, "detail.html", userrole: get_session(conn, :userrole))
  end

  def save_patient(conn, params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)

    url = "http://localhost:3000/api/prevent/profile"
    headers = [{"Content-type", "application/json"}]

    body = %{"cellphone" => params["cell_phone"],
      "email" => params["email"],
      "firstname" => params["first_name"],
      "lastname" =>  params["last_name"],
      "phone"=> params["phone"],
      "username"=> params["user_name"],
      "userpassword"=> params["user_password"],
      "userrole"=>  "patient",
      "gender"=>  params["gender"],
      "address"=> params["address"],
      "city"=> params["city"]
   }

    response = HTTPoison.post!(url, Jason.encode!(body), headers, [])

    token = get_csrf_token()

    IO.puts(response.status_code)

    if response.status_code == 201 do

      profile = Jason.decode!(response.body)

      IO.puts(profile["profileid"])

      birthday = "#{params["birthday"]}T12:00:00"

      patient_body = %{"birthday" => birthday,
        "insurancetype" => params["insurance_type"],
        "nationalid" => params["nationalid"],
        "preferredcontactmethod" => params["preferred_contact_method"],
        "profileid" => profile["profileid"]
      }

      url_patient = "http://localhost:3000/api/prevent/patient"
      response = HTTPoison.post!(url_patient , Jason.encode!(patient_body), headers, [])

      if response.status_code == 201 do
        render(conn, "new_patient.html", csrf_token: token, error_type: "success", userrole: get_session(conn, :userrole))
      else
        render(conn, "new_patient.html", csrf_token: token, error_type: "error", userrole: get_session(conn, :userrole))
      end

    else

      render(conn, "new_patient.html", csrf_token: token, error_type: "error", userrole: get_session(conn, :userrole))
    end


  end

  def new_patient(conn, _params) do
    token = get_csrf_token()
    render(conn, "new_patient.html", csrf_token: token, error_type: "ok", userrole: get_session(conn, :userrole))
  end

  def new_doctor(conn, _params) do
    token = get_csrf_token()
    render(conn, "new_doctor.html", csrf_token: token, error_type: "ok", userrole: get_session(conn, :userrole))
  end

end

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
      "userrole"=>  params["user_role"],
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

  def save_doctor(conn, params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)

    if params["mode"] == "update" do
      put_doctor(conn, params)
    else
      post_doctor(conn, params)
    end

  end

  def put_doctor(conn, params) do

    profileid = params["profile_id"]
    doctorid = params["doctor_id"]



    url = "http://localhost:3000/api/prevent/profile/#{profileid}"
    headers = [{"Content-type", "application/json"}]

    body = %{"cellphone" => params["cell_phone"],
      "email" => params["email"],
      "firstname" => params["first_name"],
      "lastname" =>  params["last_name"],
      "phone"=> params["phone"],
      "gender"=>  params["gender"],
      "address"=> params["address"],
      "city"=> params["city"]
    }

    response = HTTPoison.put!(url, Jason.encode!(body), headers, [])

    IO.puts(response.status_code)

    if response.status_code == 200 do

      profile = Jason.decode!(response.body)

      doctor_body = %{
        "realm" => params["realm"],
        "licensenumber" => params["license_number"],
        "profileid" => profile["profileid"]
      }

      url_patient = "http://localhost:3000/api/prevent/doctor/#{doctorid}"
      response = HTTPoison.put!(url_patient , Jason.encode!(doctor_body), headers, [])

      if response.status_code == 200 do
        redirect(conn, to: "/doctor")
      else
        redirect(conn, to: "/doctor")
      end

    else

      redirect(conn, to: "/doctor")
    end
  end

  def post_doctor(conn, params) do
    url = "http://localhost:3000/api/prevent/profile"
    headers = [{"Content-type", "application/json"}]

    body = %{"cellphone" => params["cell_phone"],
      "email" => params["email"],
      "firstname" => params["first_name"],
      "lastname" =>  params["last_name"],
      "phone"=> params["phone"],
      "username"=> params["user_name"],
      "userpassword"=> params["user_password"],
      "userrole"=>  params["user_role"],
      "gender"=>  params["gender"],
      "address"=> params["address"],
      "city"=> params["city"]
    }

    response = HTTPoison.post!(url, Jason.encode!(body), headers, [])

    IO.puts(response.status_code)

    if response.status_code == 201 do

      profile = Jason.decode!(response.body)

      doctor_body = %{
        "realm" => params["realm"],
        "licensenumber" => params["license_number"],
        "profileid" => profile["profileid"]
      }

      url_patient = "http://localhost:3000/api/prevent/doctor"
      response = HTTPoison.post!(url_patient , Jason.encode!(doctor_body), headers, [])

      if response.status_code == 201 do
        render_to_doctor(conn, "success", %{update: "new", doctorid: "", profileid: ""})
      else
        render_to_doctor(conn, "error", %{update: "new", doctorid: "", profileid: ""})
      end

    else

      render_to_doctor(conn, "error", %{update: "new", doctorid: "", profileid: ""})
    end
  end

  def new_doctor(conn, _params) do
    render_to_doctor(conn, "", %{update: "new", doctorid: "", profileid: ""})
  end

  def update_doctor(conn, params) do

    profileid = params["profile_id"]
    doctor_id = params["doctor_id"]

    url = "http://localhost:3000/api/prevent/profile/#{profileid}"
    headers = [{"Content-type", "application/json"}]

    response = HTTPoison.get!(url, headers, [])

    if response.status_code == 200 do
      profile = Jason.decode!(response.body)

      profile = profile |> Map.put(:update, "update")
                        |> Map.put(:doctorid, doctor_id)
                        |> Map.put(:profileid, profileid)

      render_to_doctor(conn, "", profile)
    else
      render_to_doctor(conn, "", %{update: "new", doctorid: "", profileid: ""})
    end
  end


  def render_to_doctor(conn, error_type, adult) do

    token = get_csrf_token()

    first_name = null_to_string(adult["firstname"])
    last_name = null_to_string(adult["lastname"])
    email = null_to_string(adult["email"])
    cell_phone = null_to_string(adult["cellphone"])
    phone = null_to_string(adult["phone"])
    gender = null_to_string(adult["gender"])
    address = null_to_string(adult["address"])
    city = null_to_string(adult["city"])
    realm = null_to_string(adult["realm"])
    license_number = null_to_string(adult["licensenumber"])
    update = null_to_string(adult.update)
    profileid = null_to_string(adult.profileid)
    doctorid = null_to_string(adult.doctorid)

    render(conn, "new_doctor.html",
        csrf_token: token,
        error_type: error_type,
        userrole: get_session(conn, :userrole),
        first_name: first_name,
        last_name: last_name,
        email: email,
        cell_phone: cell_phone,
        phone: phone,
        gender: gender,
        address: address,
        city: city,
        realm: realm,
        license_number: license_number,
        update: update,
        profileid: profileid,
        doctorid: doctorid)
  end

  def null_to_string(value) do
    if value == nil do
      ""
    else
      "#{value}"
    end
  end

end

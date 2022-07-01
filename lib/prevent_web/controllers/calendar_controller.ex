defmodule PreventWeb.CalendarController do
  use PreventWeb, :controller

  def index(conn, _params) do

    current_appoints = Enum.map(month_dates(), fn date -> month_map(date) end)

    IO.puts("Is List:#{is_list(current_appoints)}")

    render(conn, "calendar.html", userrole: get_session(conn, :userrole), appointments: current_appoints)
  end

  def month_dates do

    current_date = Date.utc_today
    lastday_current_month = :calendar.last_day_of_the_month(current_date.year, current_date.month)

    1..lastday_current_month |> Enum.map(&(%{date: Date.new(current_date.year, current_date.month, &1)}))
  end

  def month_map(month) do

    {:ok, date} = month.date

    day_of_week = :calendar.day_of_the_week(date.year, date.month, date.day)

    month |> Map.put("date_text", "#{Helper.day_to_text(day_of_week)}, #{Helper.month_to_text(date.month)} #{date.day}")
          |>  Map.put("appointment", [%{time: "8:00 - 9:00", patient: "Marcos Tirao"}])

  end


  def new_hospital(conn, _params) do
    token = get_csrf_token()

    render(conn, "new_hospital.html",
        csrf_token: token,
        error_type: "ok",
        userrole: get_session(conn, :userrole),
        update: "new",
        name: "",
        address: "",
        city: "",
        state: ""
        )
  end


  def update_hospital(conn, params) do

    hospitalid = params["hospital_id"]

    url = "http://localhost:3100/api/prevent/hospital/#{hospitalid}"
    headers = [{"Content-type", "application/json"}]


    IO.puts("#{url}  #{hospitalid}" )

    response = HTTPoison.get!(url, headers, [])


    process_response(response, 200, "ok", conn)

  end

  def save_hospital(conn, params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)

    if params["mode"] == "update" do
      put_hospital(conn, params)
    else
      post_hospital(conn, params)
    end
  end



  def put_hospital(conn, params) do

    hospitalid = params["hospital_id"]

    url = "http://localhost:3100/api/prevent/hospital/#{hospitalid}"
    headers = [{"Content-type", "application/json"}]

    body = %{"address" => params["address"],
      "city" => params["city"],
      "state" => params["state"],
      "name" =>  params["name"],
    }


    response = HTTPoison.put!(url, Jason.encode!(body), headers, [])

    process_response(response, 201, "success", conn)

  end

  def post_hospital(conn, params) do

    url = "http://localhost:3100/api/prevent/hospital"
    headers = [{"Content-type", "application/json"}]

    body = %{"address" => params["address"],
      "city" => params["city"],
      "state" => params["state"],
      "name" =>  params["name"],
    }

    response = HTTPoison.post!(url, Jason.encode!(body), headers, [])

    process_response(response, 201, "success", conn)

  end


  def process_response(response, status_code, status_response, conn) do

    token = get_csrf_token()

    if response.status_code == status_code do

      hospital = Jason.decode!(response.body)


      render(conn, "new_hospital.html",
        csrf_token: token,
        error_type: status_response,
        userrole: get_session(conn, :userrole),
        update: "update",
        name: hospital["name"],
        address: hospital["address"],
        city: hospital["city"],
        state: hospital["state"],
        hospitalid: hospital["id"]
        )
    else
      render(conn, "new_hospital.html",
        csrf_token: token,
        error_type: "error",
        userrole: get_session(conn, :userrole),
        update: "new",
        name: "",
        address: "",
        city: "",
        state: ""
        )
    end

  end

  def hospital_list(conn, param) do
    hospitalList =  PreventWeb.MainController.hospitals()

    doctorid = param["doctor_id"]
    render(conn, "calendar_hospital.html", doctorid: doctorid, hospitals: hospitalList |> Enum.with_index, userrole: get_session(conn, :userrole))
  end

  def doctor_availability(conn, param) do

    token = get_csrf_token()

    hospitalid = param["hospital_id"]
    doctorid = param["doctor_id"]

    render(conn, "doctor_availalability.html",
      error_type: "ok",
      csrf_token: token,
      hospitalid: hospitalid,
      doctorid: doctorid,
      userrole: get_session(conn, :userrole))

  end

  defp convert_available_day(param) do

    sun = Helper.string_to_integer(param["sun"])
    mon = Helper.string_to_integer(param["mon"])
    tue = Helper.string_to_integer(param["tue"])
    wed = Helper.string_to_integer(param["wed"])
    thu = Helper.string_to_integer(param["thu"])
    fri = Helper.string_to_integer(param["fri"])
    sat = Helper.string_to_integer(param["sat"])

    sun + mon + tue + wed + thu + fri + sat
  end

  defp time_to_float(time) do
    times = List.to_tuple(String.split(time, ":"))
    hour = String.trim(elem(times, 0))
    min = String.trim(elem(times, 1))

    hour_i = Helper.string_to_integer(hour)
    min_i = Helper.string_to_integer(min)

    hour_i + (min_i / 60)
  end

  def save_doctor_availability(conn, param) do
    token = get_csrf_token()

    hospitalid = Helper.string_to_integer(param["hospital_id"])
    doctorid = Helper.string_to_integer(param["doctor_id"])
    availableday = convert_available_day(param)
    endshift = time_to_float(param["to"])
    startshift = time_to_float(param["from"])

    url = "http://localhost:3100/api/prevent/doctor"
    headers = [{"Content-type", "application/json"}]

    body = %{"availableday" => availableday,
      "doctorid" => doctorid,
      "endshift" => endshift,
      "hospitalid" => hospitalid,
      "startshift" => startshift
    }



    response = HTTPoison.post!(url, Jason.encode!(body), headers, [])

    if response.status_code == 201 do

      render(conn, "doctor_availalability.html",
        error_type: "success",
        csrf_token: token,
        hospitalid: hospitalid,
        doctorid: doctorid,
        userrole: get_session(conn, :userrole))
    else
      render(conn, "doctor_availalability.html",
        error_type: "error",
        csrf_token: token,
        hospitalid: hospitalid,
        doctorid: doctorid,
        userrole: get_session(conn, :userrole))
    end

  end

end

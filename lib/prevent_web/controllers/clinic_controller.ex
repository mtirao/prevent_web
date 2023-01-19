defmodule PreventWeb.ClinicController do
  use PreventWeb, :controller



  def index(conn, params) do
    userid = get_session(conn, :userid)
    IO.puts(userid)
    IO.puts(get_session(conn, :userrole))

    patient = params["patient_id"]

    url = "http://localhost:3200/api/prevent/adults/#{patient}"
    headers = [{"Content-type", "application/json"}]
    response = HTTPoison.get!(url, headers, [])

    if response.status_code == 200 do
      adults = Jason.decode!(response.body)

      if length(adults) > 0 do

        adultsList = adults_list(adults)

        render(conn, "clinic.html", clinic: adultsList, patient_id: patient, userrole: get_session(conn, :userrole))
      else
        RenderHelper.render_to_obstetrics("new_pediatrics.html", conn, "", %{"patient_id" => patient})
       # render_to_adult("new_adult.html", conn, "", %{"patient_id" => patient})
      end
    else
      # render_to_adult("new_gynocoligies.html", conn, "", %{"patient_id" => patient})
      RenderHelper.render_to_adult("new_adult.html", conn, "", %{"patient_id" => patient})
    end


  end

  def new(conn, params) do

    url = "http://localhost:3200/api/prevent/adult/last"
    headers = [{"Content-type", "application/json"}]
    response = HTTPoison.get!(url, headers, [])

    if response.status_code == 200 do
      adult = Jason.decode!(response.body)

      if adult["nutritionalvalue"] == 0 do
        RenderHelper.render_to_adult("new_adult.html", conn, "", adult)
      else
        RenderHelper.render_to_adult("new_adult.html", conn, "", adult)
      end
    else
      RenderHelper.render_to_adult("new_adult.html", conn, "", %{"patient_id" => params["patient_id"]})
    end

  end

  def detail(conn, params) do


    url = "http://localhost:3200/api/prevent/adult/#{params["adult_id"]}"
    headers = [{"Content-type", "application/json"}]
    response = HTTPoison.get!(url, headers, [])

    if response.status_code == 200 do
      adult = Jason.decode!(response.body)


      RenderHelper.render_to_adult("detail_adult.html", conn, "", adult)
    else
      RenderHelper.render_to_adult("detail_adult.html", conn, "", %{})
    end


  end

  def new_adult(conn, params) do

    json = RenderHelper.parameters_to_json_adult(params)

    url = "http://localhost:3200/api/prevent/adult"
    headers = [{"Content-type", "application/json"}]
    response = HTTPoison.post!(url, Jason.encode!(json), headers, [])

    if response.status_code == 201 do
      adult = Jason.decode!(response.body)
      patient = adult["patientid"]
      redirect(conn, to: "/clinic?patient_id=#{patient}")
    else
      token = get_csrf_token()
      render(conn, "new_adult.html", csrf_token: token, error_type: "error", patient_id: params["patient_id"])
    end
  end

  def adults_list(adults) do

    Enum.map(adults, fn adult -> adults_map(adult) end)

  end

  def adults_map(adult) do

    adult |> Map.put("nutritionalvalue_text", Helper.nutritional_to_text(adult["nutritionalvalue"]))
          |> Map.put("date_formatted", Helper.string_to_date_formatted(adult["date"]))
  end

end

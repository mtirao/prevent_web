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

end

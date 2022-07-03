defmodule Helper do

  def imc(height, weight) do
    IO.puts("Height:#{height}, Weight:#{weight}")
    if height != 0 do
      imc = weight / (height * height)
      IO.puts("IMC: #{imc}")
      cond do
        imc < 18.5 ->  4
        imc > 18.5 and imc <= 25 -> 1
        imc > 25 and imc <= 30 ->  2
        imc > 30 -> 3
      end
    else
      0
    end

  end

  def string_to_boolean(text) do

    if text == nil do
      false
    else
      result = Integer.parse(text)

      if result == :error do
        false
      else
        if elem(result, 0) == 1, do: true, else: false
      end
    end

  end

  def string_to_float(text) do

    if text == nil do
      0
    else
      result = Float.parse(text)

      if result == :error do
        0
      else
        elem(result, 0)
      end
    end

  end

  def string_to_integer(text) do

    if text == nil do
      0
    else
      result = Integer.parse(text)

      if result == :error do
        0
      else
        elem(result, 0)
      end
    end

  end

  def nutritional_to_text(value) do

    cond do
      value == 4 ->  "Underweight"
      value == 1 -> "Normal"
      value == 2 ->   "Overweight"
      value == 3 -> "Obesity"
      true -> "Unavailble"
    end
  end

  def string_to_date_formatted(date) do

    {:ok, value} = DateTimeParser.parse(date)
    "#{value.year}/#{value.month}/#{value.day}"

  end

  def month_to_text(month) do
    cond do
      month == 1 -> "January"
      month == 2 -> "February"
      month == 3 -> "March"
      month == 4 -> "April"
      month == 5 -> "May"
      month == 6 -> "June"
      month == 7 -> "July"
      month == 8 -> "August"
      month == 9 -> "September"
      month == 10 -> "October"
      month == 11 -> "November"
      month == 12 -> "December"
      true -> "Unavailble"
    end
  end

  def day_to_text(day) do
    cond do
      day == 1 -> "Monday"
      day == 2 -> "Tuesday"
      day == 3 -> "Wednesday"
      day == 4 -> "Thursday"
      day == 5 -> "Friday"
      day == 6 -> "Saturday"
      day == 7 -> "Sunday"
      true -> "Unavailble"
    end
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

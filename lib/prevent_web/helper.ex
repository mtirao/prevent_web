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

end

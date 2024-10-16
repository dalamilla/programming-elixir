defmodule Timestamp.Parser do
  def parsing_date(date) do
    tz_fun = fn naive_datetime, abbr, _offset ->
      {:ok, naive_datetime |> DateTime.from_naive!(abbr)}
    end

    cond do
      String.match?(date, ~r/^[0-9]{13}$/) ->
        DateTime.from_unix(String.to_integer(date), :millisecond)

      String.match?(date, ~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/) ->
        Datix.DateTime.parse(date, "%Y-%m-%d")

      String.match?(date, ~r/^[0-9]{2} [a-zA-Z]+ [0-9]{4}$/) ->
        Datix.DateTime.parse(date, "%d %B %Y")

      String.match?(date, ~r/^[0-9]{2} [a-zA-Z]+ [0-9]{4}, [A-Z]+$/) ->
        Datix.DateTime.parse(date, "%d %B %Y, %Z", time_zone: tz_fun)

      true ->
        {:error, :invalid_format}
    end
  end
end

defmodule ExerciseTracker.Parser do
  def parsing_date(date) do
    cond do
      is_nil(date) ->
        {:ok, Date.utc_today()}

      String.match?(date, ~r/^[a-zA-z]+ [a-zA-z]+ [0-9]{2} [0-9]{4}+$/) ->
        Datix.Date.parse(date, "%a %b %d %Y")

      String.match?(date, ~r/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/) ->
        Datix.Date.parse(date, "%Y-%m-%d")

      true ->
        {:error, :invalid_format}
    end
  end

  def parsing_filter_date(date) do
    case Datix.Date.parse(date, "%Y-%m-%d") do
      {:ok, date} -> date
      _ -> nil
    end
  end

  def parsing_filter_limit(limit) when is_nil(limit) do
    nil
  end

  def parsing_filter_limit(limit) do
    case Integer.parse(limit) do
      {int, ""} -> int
      _ -> nil
    end
  end
end

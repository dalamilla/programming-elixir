defmodule TimestampWeb.TimestampController do
  use TimestampWeb, :controller

  def now(conn, _params) do
    {:ok, date_now} = DateTime.now("GMT")
    unix = date_now |> DateTime.to_unix(:millisecond)
    utc = Calendar.strftime(date_now, "%a, %d %b %Y %H:%M:%S %Z")

    info = %{
      unix: unix,
      utc: utc
    }

    render(conn, :index, info: info)
  end

  def idate(conn, %{"input_date" => input_date}) do
    case Timestamp.Parser.parsing_date(input_date) do
      {:ok, date_with_time} ->
        unix = date_with_time |> DateTime.to_unix(:millisecond)

        utc =
          date_with_time
          |> DateTime.shift_zone!("GMT")
          |> Calendar.strftime("%a, %d %b %Y %H:%M:%S %Z")

        info = %{
          unix: unix,
          utc: utc
        }

        render(conn, :index, info: info)

      {:error, _} ->
        error = %{
          error: "Invalid Date"
        }

        conn
        |> put_status(400)
        |> render(:error, error: error)
    end
  end
end

defmodule TimestampWeb.TimestampControllerTest do
  use TimestampWeb.ConnCase

  test "GET /api/2016-12-25", %{conn: conn} do
    conn =
      conn
      |> get("/api/2016-12-25")

    assert %{
             "unix" => 1_482_624_000_000,
             "utc" => "Sun, 25 Dec 2016 00:00:00 GMT"
           } = json_response(conn, 200)
  end

  test "GET /api/1451001600000", %{conn: conn} do
    conn =
      conn
      |> get("/api/1451001600000")

    assert %{
             "unix" => 1_451_001_600_000,
             "utc" => "Fri, 25 Dec 2015 00:00:00 GMT"
           } = json_response(conn, 200)
  end

  test "GET /api/05%20October%202011", %{conn: conn} do
    conn =
      conn
      |> get("/api/05%20October%202011")

    assert %{
             "unix" => 1_317_772_800_000,
             "utc" => "Wed, 05 Oct 2011 00:00:00 GMT"
           } = json_response(conn, 200)
  end

  test "GET /api/05%20October%202011%2C%20GMT", %{conn: conn} do
    conn =
      conn
      |> get("/api/05%20October%202011%2C%20GMT")

    assert %{
             "unix" => 1_317_772_800_000,
             "utc" => "Wed, 05 Oct 2011 00:00:00 GMT"
           } = json_response(conn, 200)
  end

  test "GET /api/this-is-not-a-date", %{conn: conn} do
    conn =
      conn
      |> get("/api/this-is-not-a-date")

    assert %{
             "error" => "Invalid Date"
           } = json_response(conn, 400)
  end

  test "GET /api", %{conn: conn} do
    {:ok, date_now} = DateTime.now("GMT")
    utc = Calendar.strftime(date_now, "%a, %d %b %Y %H:%M:%S %Z")

    conn =
      conn
      |> get("/api")

    {:ok, time_unix} =
      json_response(conn, 200)["unix"]
      |> DateTime.from_unix(:millisecond)

    assert DateTime.diff(time_unix, date_now) == 0
    assert json_response(conn, 200)["utc"] == utc
  end
end

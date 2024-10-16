defmodule UrlShortenerWeb.UrlShortenerControllerTest do
  use UrlShortenerWeb.ConnCase

  test "POST /api/shorturl/100", %{conn: conn} do
    conn =
      conn
      |> get("/api/shorturl/100")

    assert %{
             "error" => "No short URL found for the given input"
           } = json_response(conn, 200)
  end

  test "GET /api/shorturl/text", %{conn: conn} do
    conn =
      conn
      |> get("/api/shorturl/text")

    assert %{
             "error" => "Wrong format"
           } = json_response(conn, 200)
  end

  test "POST /api/shorturl Invalid url", %{conn: conn} do
    conn =
      conn
      |> post("/api/shorturl", %{url: "htt://example.com"})

    assert %{
             "error" => "Invalid url"
           } = json_response(conn, 200)
  end

  test "POST /api/shorturl Invalid hostname", %{conn: conn} do
    conn =
      conn
      |> post("/api/shorturl", %{url: "http://examplesss.com"})

    assert %{
             "error" => "Invalid Hostname"
           } = json_response(conn, 200)
  end

  test "POST /api/shorturl Valid url", %{conn: conn} do
    conn =
      conn
      |> post("/api/shorturl", %{url: "https://elixir-lang.org"})

    assert json_response(conn, 200)["original_url"] == "https://elixir-lang.org"
  end

  test "POST /api/shorturl Redirect", %{conn: conn} do
    conn =
      conn
      |> post("/api/shorturl", %{url: "https://www.phoenixframework.org"})

    id = json_response(conn, 200)["short_url"]

    conn =
      conn
      |> get("/api/shorturl/#{id}")

    assert conn.status == 302
    assert conn.resp_body =~ "https://www.phoenixframework.org"
  end
end

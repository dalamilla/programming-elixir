defmodule RequestHeaderWeb.WhoamiControllerTest do
  use RequestHeaderWeb.ConnCase

  test "GET /api/whoami", %{conn: conn} do
    conn =
      conn
      |> put_req_header(
        "user-agent",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"
      )
      |> put_req_header("accept-language", "en-US,en;q=0.9")
      |> get("/api/whoami")

    assert json_response(conn, 200)["ipaddress"] == "127.0.0.1"
    assert json_response(conn, 200)["language"] == "en-US,en;q=0.9"

    assert json_response(conn, 200)["software"] ==
             "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36"
  end
end

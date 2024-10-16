defmodule FileMetadataWeb.FileMetadataControllerTest do
  use FileMetadataWeb.ConnCase

  test "GET /api/fileanalyse txt", %{conn: conn} do
    upload = %Plug.Upload{
      path: "test/fixtures/test.txt",
      filename: "test.txt",
      content_type: "text/plain"
    }

    conn =
      conn
      |> post("/api/fileanalyse", %{:upfile => upload})

    assert %{
             "name" => "test.txt",
             "size" => "14",
             "type" => "text/plain"
           } = json_response(conn, 200)
  end

  test "GET /api/fileanalyse json", %{conn: conn} do
    upload = %Plug.Upload{
      path: "test/fixtures/test.json",
      filename: "test.json",
      content_type: "application/json"
    }

    conn =
      conn
      |> post("/api/fileanalyse", %{:upfile => upload})

    assert %{
             "name" => "test.json",
             "size" => "39",
             "type" => "application/json"
           } = json_response(conn, 200)
  end

  test "GET /api/fileanalyse img", %{conn: conn} do
    upload = %Plug.Upload{
      path: "test/fixtures/test.png",
      filename: "test.png",
      content_type: "image/png"
    }

    conn =
      conn
      |> post("/api/fileanalyse", %{:upfile => upload})

    assert %{
             "name" => "test.png",
             "size" => "13736",
             "type" => "image/png"
           } = json_response(conn, 200)
  end
end

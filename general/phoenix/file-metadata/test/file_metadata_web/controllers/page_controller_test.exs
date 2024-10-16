defmodule FileMetadataWeb.PageControllerTest do
  use FileMetadataWeb.ConnCase

  test "GET / title", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "FileMetadata"
  end

  test "GET / form name", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "upfile"
  end
end

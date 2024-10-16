defmodule ExerciseTrackerWeb.ExerciseTrackerControllerTest do
  use ExerciseTrackerWeb.ConnCase

  test "GET /api/users Empty", %{conn: conn} do
    conn =
      conn
      |> get("/api/users")

    assert [] == json_response(conn, 200)
  end

  test "POST /api/users Create", %{conn: conn} do
    conn =
      conn
      |> post("/api/users", %{username: "thomas"})

    assert "thomas" = json_response(conn, 200)["username"]
  end

  test "GET /api/users/:id/logs Empty logs", %{conn: conn} do
    conn =
      conn
      |> post("/api/users", %{username: "luke"})

    id = json_response(conn, 200)["_id"]

    conn =
      conn
      |> get("/api/users/#{id}/logs")

    assert [] = json_response(conn, 200)["log"]
  end

  test "POST /api/users/:id/exercises", %{conn: conn} do
    conn =
      conn
      |> post("/api/users", %{username: "cam"})

    id = json_response(conn, 200)["_id"]
    data = %{description: "run day", duration: 60, date: "2021-01-11"}

    conn =
      conn
      |> post("/api/users/#{id}/exercises", data)

    assert %{
             "_id" => id,
             "description" => "run day",
             "duration" => 60,
             "date" => "Mon Jan 11 2021",
             "username" => "cam"
           } == json_response(conn, 200)
  end

  test "GET /api/users/:id/logs filters", %{conn: conn} do
    conn =
      conn
      |> post("/api/users", %{username: "greg"})

    id = json_response(conn, 200)["_id"]

    conn =
      conn
      |> post("/api/users/#{id}/exercises", %{
        description: "run day",
        duration: 60,
        date: "2021-02-10"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "jump day",
        duration: 60,
        date: "2021-02-11"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "run day",
        duration: 60,
        date: "2021-02-12"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "jump day",
        duration: 60,
        date: "2021-02-13"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "run day",
        duration: 60,
        date: "2021-02-14"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "jump day",
        duration: 60,
        date: "2021-02-14"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "run day",
        duration: 60,
        date: "2021-02-15"
      })
      |> post("/api/users/#{id}/exercises", %{
        description: "jump day",
        duration: 60,
        date: "2021-02-16"
      })

    conn =
      conn
      |> get("/api/users/#{id}/logs?limit=2")

    assert json_response(conn, 200)["count"] == 2

    conn =
      conn
      |> get("/api/users/#{id}/logs?from=2021-02-13")

    assert json_response(conn, 200)["count"] == 5

    conn =
      conn
      |> get("/api/users/#{id}/logs?to=2021-02-15")

    assert json_response(conn, 200)["count"] == 7

    conn =
      conn
      |> get("/api/users/#{id}/logs?from=2021-02-11&to=2021-02-14")

    assert json_response(conn, 200)["count"] == 5
  end
end

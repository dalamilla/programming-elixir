defmodule ExerciseTrackerWeb.ExerciseTrackerController do
  use ExerciseTrackerWeb, :controller

  alias ExerciseTracker.Tracker
  alias ExerciseTracker.User
  alias ExerciseTracker.Exercise

  def show_users(conn, _param) do
    users = Tracker.list_users()
    render(conn, :index, users: users)
  end

  def create_user(conn, param) do
    case Tracker.create_user(param) do
      {:ok, %User{} = user} -> render(conn, :create, user: user)
      {:error, changeset} -> render(conn, :errors, changeset: changeset)
    end
  end

  def show_logs(conn, %{"id" => id}) do
    case Tracker.list_logs(id, conn.query_params) do
      nil -> render(conn, :error, error: %{error: "User not found"})
      logs -> render(conn, :index, logs: logs)
    end
  end

  def create_exercises(conn, %{"id" => id}) do
    case ExerciseTracker.Parser.parsing_date(conn.body_params["date"]) do
      {:ok, date} ->
        map = Map.put(conn.body_params, "date", date)

        case Tracker.create_exercise(id, map) do
          {:ok, %Exercise{} = exercise} -> render(conn, :create, exercise: exercise)
          {:error, changeset} -> render(conn, :errors, changeset: changeset)
        end

      {:error, _} ->
        render(conn, :error, error: %{error: "Invalid Date"})
    end
  end
end

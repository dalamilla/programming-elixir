defmodule ExerciseTrackerWeb.ExerciseTrackerJSON do
  alias ExerciseTracker.User
  alias ExerciseTracker.Exercise

  def index(%{users: users}) do
    for(user <- users, do: data(user))
  end

  def index(%{logs: logs}) do
    %{
      _id: to_string(logs.id),
      username: logs.username,
      count: length(logs.exercises),
      log: for(log <- logs.exercises, do: data(log))
    }
  end

  def create(%{user: user}) do
    %{_id: to_string(user.id), username: user.username}
  end

  def create(%{exercise: exercise}) do
    %{
      _id: to_string(exercise.user.id),
      username: exercise.user.username,
      description: exercise.description,
      duration: exercise.duration,
      date: Calendar.strftime(exercise.date, "%a %b %d %Y")
    }
  end

  def error(%{error: error}) do
    %{error: error.error}
  end

  def errors(%{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  defp data(%User{} = user) do
    %{
      _id: to_string(user.id),
      username: user.username
    }
  end

  defp data(%Exercise{} = exercise) do
    %{
      description: exercise.description,
      duration: exercise.duration,
      date: Calendar.strftime(exercise.date, "%a %b %d %Y")
    }
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end

defmodule ExerciseTracker.Tracker do
  import Ecto.Query, warn: false
  alias ExerciseTracker.Repo

  alias ExerciseTracker.User
  alias ExerciseTracker.Exercise

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list logs(exercises) of user.
  """
  def list_logs(id, params) do
    limit = ExerciseTracker.Parser.parsing_filter_limit(params["limit"])
    from_date = ExerciseTracker.Parser.parsing_filter_date(params["from"])
    to_date = ExerciseTracker.Parser.parsing_filter_date(params["to"])

    filter =
      cond do
        is_nil(from_date) and is_nil(to_date) ->
          from e in Exercise, limit: ^limit

        is_nil(from_date) ->
          from e in Exercise, where: e.date <= ^to_date, limit: ^limit

        is_nil(to_date) ->
          from e in Exercise, where: e.date >= ^from_date, limit: ^limit

        true ->
          from e in Exercise, where: e.date <= ^to_date and e.date >= ^from_date, limit: ^limit
      end

    Repo.get(User, id) |> Repo.preload(exercises: filter)
  end

  @doc """
  Creates a exercise.
  """
  def create_exercise(id, attrs \\ %{}) do
    user = Repo.get(User, id)

    %Exercise{}
    |> Exercise.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end
end

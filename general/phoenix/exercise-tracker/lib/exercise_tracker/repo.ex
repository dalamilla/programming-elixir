defmodule ExerciseTracker.Repo do
  use Ecto.Repo,
    otp_app: :exercise_tracker,
    adapter: Ecto.Adapters.Postgres
end

defmodule ExerciseTracker.Repo.Migrations.CreateExercises do
  use Ecto.Migration

  def change do
    create table(:exercises) do
      add :description, :text
      add :duration, :integer
      add :date, :date
      add :user_id, references(:users)

      timestamps(type: :utc_datetime)
    end

    create index(:exercises, [:user_id])
  end
end

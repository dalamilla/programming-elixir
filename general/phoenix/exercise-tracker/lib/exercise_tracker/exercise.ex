defmodule ExerciseTracker.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :date, :date
    field :description, :string
    field :duration, :integer
    belongs_to :user, ExerciseTracker.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:description, :duration, :date])
    |> validate_required([:description, :duration, :date])
  end
end

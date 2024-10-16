defmodule ExerciseTracker.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    has_many :exercises, ExerciseTracker.Exercise

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end

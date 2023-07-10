defmodule ExerciseTrackerWeb.Router do
  use ExerciseTrackerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExerciseTrackerWeb do
    pipe_through :api
  end
end

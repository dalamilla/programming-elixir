defmodule ExerciseTrackerWeb.Router do
  use ExerciseTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ExerciseTrackerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/", ExerciseTrackerWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", ExerciseTrackerWeb do
    pipe_through :api
    get "/users", ExerciseTrackerController, :show_users
    post "/users", ExerciseTrackerController, :create_user
    get "/users/:id/logs", ExerciseTrackerController, :show_logs
    post "/users/:id/exercises", ExerciseTrackerController, :create_exercises
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExerciseTrackerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:exercise_tracker, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ExerciseTrackerWeb.Telemetry
    end
  end
end

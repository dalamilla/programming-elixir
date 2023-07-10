defmodule ExerciseTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExerciseTracker.Repo,
      # Start the Telemetry supervisor
      ExerciseTrackerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExerciseTracker.PubSub},
      # Start the Endpoint (http/https)
      ExerciseTrackerWeb.Endpoint
      # Start a worker by calling: ExerciseTracker.Worker.start_link(arg)
      # {ExerciseTracker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExerciseTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExerciseTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule FileMetadata.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FileMetadataWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:file_metadata, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FileMetadata.PubSub},
      # Start a worker by calling: FileMetadata.Worker.start_link(arg)
      # {FileMetadata.Worker, arg},
      # Start to serve requests, typically the last entry
      FileMetadataWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FileMetadata.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FileMetadataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

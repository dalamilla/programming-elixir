defmodule FileMetadataWeb.Router do
  use FileMetadataWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FileMetadataWeb do
    pipe_through :api
  end
end

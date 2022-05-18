defmodule RequestHeaderWeb.Router do
  use RequestHeaderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RequestHeaderWeb do
    pipe_through :api
  end
end

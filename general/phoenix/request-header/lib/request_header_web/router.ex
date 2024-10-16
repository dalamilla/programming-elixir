defmodule RequestHeaderWeb.Router do
  use RequestHeaderWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api", RequestHeaderWeb do
    pipe_through :api
    get "/whoami", WhoamiController, :index
  end
end

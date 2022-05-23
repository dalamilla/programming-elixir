defmodule RequestHeaderWeb.Router do
  use RequestHeaderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :cors do
    plug CORSPlug
  end

  scope "/api", RequestHeaderWeb do
    pipe_through [:cors, :api]
    get "/whoami", WhoamiController, :index
  end
end

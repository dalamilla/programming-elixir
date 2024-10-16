defmodule TimestampWeb.Router do
  use TimestampWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/api", TimestampWeb do
    pipe_through :api
    get "/", TimestampController, :now
    get "/:input_date", TimestampController, :idate
  end
end

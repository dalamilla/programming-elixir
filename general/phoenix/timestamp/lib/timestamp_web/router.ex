defmodule TimestampWeb.Router do
  use TimestampWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimestampWeb do
    pipe_through :api
  end
end

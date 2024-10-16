defmodule TimestampWeb.TimestampJSON do
  def index(%{info: info}) do
    %{unix: info.unix, utc: info.utc}
  end

  def error(%{error: error}) do
    %{error: error.error}
  end
end

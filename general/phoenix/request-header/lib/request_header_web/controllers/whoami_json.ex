defmodule RequestHeaderWeb.WhoamiJSON do
  def index(%{info: info}) do
    %{ipaddress: info.ip, language: info.lang, software: info.soft}
  end
end

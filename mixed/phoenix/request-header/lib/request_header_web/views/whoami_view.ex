defmodule RequestHeaderWeb.WhoamiView do
  use RequestHeaderWeb, :view

  def render("index.json", %{info: info}) do
    %{ipaddress: info.ip, language: info.lang, software: info.soft}
  end
end

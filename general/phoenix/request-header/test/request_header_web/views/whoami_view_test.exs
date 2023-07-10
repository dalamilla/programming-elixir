defmodule RequestHeaderWeb.WhoamiViewTest do
  use RequestHeaderWeb.ConnCase, async: true

  import Phoenix.View

  test "renders index.json" do
    info = %{
      ip: "192.168.1.2",
      lang: "en-US",
      soft: "Mozilla/5.0 (X11; Linux x86_64)"
    }

    assert render(RequestHeaderWeb.WhoamiView, "index.json", %{info: info}) == %{
             ipaddress: info.ip,
             language: info.lang,
             software: info.soft
           }
  end
end

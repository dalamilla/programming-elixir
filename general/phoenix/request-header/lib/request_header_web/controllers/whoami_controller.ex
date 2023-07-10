defmodule RequestHeaderWeb.WhoamiController do
  use RequestHeaderWeb, :controller

  def index(conn, _params) do
    headers = Enum.into(conn.req_headers, %{})
    ip = conn.remote_ip |> Tuple.to_list() |> Enum.join(".")

    info = %{
      ip: ip,
      soft: headers["user-agent"],
      lang: headers["accept-language"]
    }

    render(conn, "index.json", info: info)
  end
end

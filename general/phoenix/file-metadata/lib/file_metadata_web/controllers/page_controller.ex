defmodule FileMetadataWeb.PageController do
  use FileMetadataWeb, :controller

  def form(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    form = %{"upfile" => "upfile"}
    render(conn, :form, layout: false, form: form, action: ~p"/api/fileanalyse")
  end
end

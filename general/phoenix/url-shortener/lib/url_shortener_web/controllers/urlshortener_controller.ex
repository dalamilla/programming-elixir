defmodule UrlShortenerWeb.UrlShortenerController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Shortener
  alias UrlShortener.Url

  def create(conn, param) do
    case Shortener.create_url(param) do
      {:ok, %Url{} = url} -> render(conn, :create, url: url)
      {:error, changeset} -> render(conn, :error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    if String.match?(id, ~r/^[0-9]+$/) do
      case Shortener.get_url(id) do
        nil ->
          error = %{error: "No short URL found for the given input"}
          render(conn, :error, error: error)

        url ->
          redirect(conn, external: url.url)
      end
    else
      error = %{error: "Wrong format"}
      render(conn, :error, error: error)
    end
  end
end

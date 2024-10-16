defmodule UrlShortener.Shortener do
  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.Url

  @doc """
  Creates a url.
  """
  def create_url(attrs \\ %{}) do
    %Url{}
    |> Url.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single url.
  """
  def get_url(id), do: Repo.get(Url, id)
end

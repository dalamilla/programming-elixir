defmodule UrlShortenerWeb.UrlShortenerJSON do
  def create(%{url: url}) do
    %{short_url: url.id, original_url: url.url}
  end

  def error(%{error: error}) do
    %{error: error.error}
  end

  def error(%{changeset: changeset}) do
    {error, _} = changeset.errors[:name]
    %{error: error}
  end
end

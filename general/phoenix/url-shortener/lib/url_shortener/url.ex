defmodule UrlShortener.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> validate_url()
  end

  defp validate_url(changeset) do
    url = get_field(changeset, :url)
    uri = URI.parse(url)

    cond do
      not (uri.scheme != nil && uri.scheme =~ ~r/http|https/ && uri.host =~ ".") ->
        add_error(changeset, :name, "Invalid url")

      uri.host != nil ->
        case :inet_res.nslookup(~c"#{uri.host}", :in, :txt) do
          {:ok, _} -> changeset
          {:error, :nxdomain} -> add_error(changeset, :name, "Invalid Hostname")
        end

      true ->
        changeset
    end
  end
end

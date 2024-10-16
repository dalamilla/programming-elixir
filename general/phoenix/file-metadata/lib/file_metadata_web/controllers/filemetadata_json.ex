defmodule FileMetadataWeb.FileMetadataJSON do
  def index(%{info: info}) do
    %{name: info.name, type: info.type, size: info.size}
  end

  def error(%{error: error}) do
    %{error: error.error}
  end
end

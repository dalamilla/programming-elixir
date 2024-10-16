defmodule FileMetadataWeb.FileMetadataController do
  use FileMetadataWeb, :controller

  def analyse(conn, %{"upfile" => upfile}) do
    name = upfile.filename
    type = upfile.content_type
    %{size: size} = File.stat!(upfile.path)

    info = %{
      name: name,
      type: type,
      size: to_string(size)
    }

    render(conn, :index, info: info)
  end
end

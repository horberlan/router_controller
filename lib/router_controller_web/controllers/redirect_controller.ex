defmodule RouterControllerWeb.RedirectController do
  use RouterControllerWeb, :controller

  def index(conn, _params) do
    base_url = "http://localhost:3000"
    redirect(conn, external: "#{base_url}?data=#{URI.encode_query(%{key: "value"})}")
  end

  def page(conn, _params) do
    base_url = "http://localhost:5173"
    redirect(conn, external: "#{base_url}?data=#{URI.encode_query(%{key: "value"})}")
  end
end

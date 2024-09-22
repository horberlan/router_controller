defmodule RouterControllerWeb.RedirectController do
  use RouterControllerWeb, :controller

  def index(conn, _params) do
    base_url = Application.get_env(:router_controller_web, :base_url, "http://localhost:3000")
    redirect(conn, external: "#{base_url}?data=#{URI.encode_query(%{key: "value"})}")
  end

  def page(conn, _params) do
    # If you want a different base_url for this function, you can set another environment variable
    base_url = Application.get_env(:router_controller_web, :base_url_for_page, "http://localhost:5173")
    redirect(conn, external: "#{base_url}?data=#{URI.encode_query(%{key: "value"})}")
  end
end

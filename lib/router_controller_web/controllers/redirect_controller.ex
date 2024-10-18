defmodule RouterControllerWeb.RedirectController do
  use RouterControllerWeb, :controller

  def index(conn, %{"user_name" => user_name}) do
    base_url = Application.get_env(:router_controller_web, :base_url)

    if String.trim(user_name) == "" do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Missing 'user_name' parameter"})
    else
      conn
      |> increment_access_counter()
      |> redirect_to_user_page(base_url, user_name)
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Missing 'user_name' parameter"})
  end

  def page(conn, _params) do
    base_url_for_page = Application.get_env(:router_controller_web, :base_url_for_page)

    conn
    |> put_session(:user_data, "value")
    |> redirect_to_page(base_url_for_page)
  end

  defp increment_access_counter(conn) do
    current_counter = get_session(conn, :access_counter) || 0

    conn
    |> put_session(:access_counter, current_counter + 1)
  end

  defp redirect_to_user_page(conn, base_url, user_name) do
    access_counter = get_session(conn, :access_counter)
    redirect(conn, external: "#{base_url}/#{user_name}?access=#{access_counter}")
  end

  defp redirect_to_page(conn, base_url_for_page) do
    redirect(conn, external: "#{base_url_for_page}?#{URI.encode_query(user_data: "value")}")
  end
end

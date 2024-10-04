defmodule RouterControllerWeb.RedirectController do
  use RouterControllerWeb, :controller

  def index(conn, %{"user_name" => user_name}) do
    base_url = Application.get_env(:router_controller_web, :base_url)

    conn
    |> put_session(:user_data, "#{user_name}")
    |> redirect(external:  "#{base_url}/#{user_name}")
    conn
    |> send_resp(400, "Parâmetro 'user_data' não foi fornecido.")
  end

  def page(conn, _params) do
    base_url_for_page =
      Application.get_env(:router_controller_web, :base_url_for_page)

    data = %{user_data: "value"}

    conn
    |> put_session(:user_data, "value")
    |> redirect(external: "#{base_url_for_page}?#{URI.encode_query(data)}")
  end
end

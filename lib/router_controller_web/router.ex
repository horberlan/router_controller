defmodule RouterControllerWeb.Router do
  use RouterControllerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", RouterControllerWeb do
    pipe_through :browser

    get "/", RedirectController, :index
    get "/page", RedirectController, :page
  end
end

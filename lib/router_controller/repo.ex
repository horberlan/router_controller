defmodule RouterController.Repo do
  use Ecto.Repo,
    otp_app: :router_controller,
    adapter: Ecto.Adapters.Postgres
end

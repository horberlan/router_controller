defmodule RouterController.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  @impl true
  def start(_type, _args) do
    Dotenv.load()

    children = [
      RouterControllerWeb.Telemetry,
      RouterController.Repo,
      {DNSCluster, query: Application.get_env(:router_controller, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RouterController.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RouterController.Finch},
      # Start a worker by calling: RouterController.Worker.start_link(arg)
      # {RouterController.Worker, arg},
      # Start to serve requests, typically the last entry
      RouterControllerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RouterController.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RouterControllerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

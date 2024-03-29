defmodule BlogApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BlogApiWeb.Telemetry,
      # Start the Ecto repository
      BlogApi.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BlogApi.PubSub},
      # Start Finch
      {Finch, name: BlogApi.Finch},
      # Start the Endpoint (http/https)
      BlogApiWeb.Endpoint
      # Start a worker by calling: BlogApi.Worker.start_link(arg)
      # {BlogApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BlogApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BlogApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

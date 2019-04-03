defmodule KvStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      bots: [
        strategy: Cluster.Strategy.Epmd,
        config: [
          hosts: [:kv@bot00, :kv@bot01, :kv@bot02, :kv@bot03, :kv@bot04]
        ],
      ],
    ]

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: KvStore.Worker.start_link(arg)
      # {KvStore.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: KvStore.ClusterSupervisor]]},
      KvStore.MapServer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KvStore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule KvStore do
  def get(k) do
    # Need one node, so grab the local copy.
    KvStore.MapServer.get(k)
  end

  def put(k, v) do
    nodes = [Node.self() | Node.list()]
    results = Enum.map nodes, fn node ->
      KvStore.MapServer.put(node, k, v)
    end
    if Enum.all?(results, &(&1 == :ok)) do
      :ok
    else
      {:error, "didn't write to all replicas"}
    end
  end
end

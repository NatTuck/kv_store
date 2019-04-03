defmodule KvStore.MapServer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def put(k, v) do
    GenServer.call(__MODULE__, {:put, k, v})
  end

  def get(k) do
    GenServer.call(__MODULE__, {:get, k})
  end

  def put(node, k, v) do
    GenServer.call({__MODULE__, node}, {:put, k, v})
  end

  def get(node, k) do
    GenServer.call({__MODULE__, node}, {:get, k})
  end

  @impl true
  def init(default) do
    # Get the map from all remote nodes.
    {replies, _} = GenServer.multi_call(Node.list(), __MODULE__, :get_map, 1000)
    if Enum.empty?(replies) do
      {:ok, default}
    else
      # All nodes have the current state, so we just take the first one.
      {_node, map} = hd(replies)
      {:ok, map}
    end
  end

  @impl true
  def handle_call({:put, k, v}, _from, state) do
    state = Map.put(state, k, v)
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:get, k}, _from, state) do
    {:reply, Map.get(state, k), state}
  end

  @impl true
  def handle_call(:get_map, _from, state) do
    {:reply, state, state}
  end
end

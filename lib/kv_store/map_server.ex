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

  @impl true
  def init(map) do
    {:ok, map}
  end

  @impl true
  def handle_call({:put, k, v}, _from, state) do
    state = Map.put(state, k, v)
    {:reply, :ok, state}
  end

  def handle_call({:get, k}, _from, state) do
    {:reply, Map.get(state, k), state}
  end
end

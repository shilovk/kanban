defmodule KVStoreTest do
  use ExUnit.Case
  doctest Kanban.KVStore

  test "method put" do
    {:ok, _pid} = Kanban.KVStore.start_link(%{kats: ['Tom']})
    GenServer.call(Kanban.KVStore, {:put, :kats, 'Felix'})
    values = GenServer.call(Kanban.KVStore, {:put, :dogs, 'Oliver'})
    assert %{dogs: ['Oliver'], kats: ['Felix', 'Tom']} = values
  end

  test "method get" do
    {:ok, _pid} = Kanban.KVStore.start_link(%{kats: ['Tom']})
    value = GenServer.call(Kanban.KVStore, {:get, {:kats, 0}})
    assert 'Tom' = value
  end
end

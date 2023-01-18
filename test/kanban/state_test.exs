defmodule StateTest do
  use ExUnit.Case
  doctest Kanban.TaskFSM
  doctest Kanban.TaskManager
  doctest Kanban.State

  alias Kanban.{TaskRegistry, TaskFSM, TaskManager, State}

  test "state" do
    (1..2)
    |> Enum.map(&"T_#{&1}")
    |> Enum.map(&TaskManager.start_task(&1, 3, "Project1"))
    TaskFSM.start({:via, Registry, {TaskRegistry, "T_1"}})
    TaskFSM.finish({:via, Registry, {TaskRegistry, "T_1"}})
    TaskFSM.start({:via, Registry, {TaskRegistry, "T_2"}})
    Process.sleep(100)
    assert ["doing"] == State.state |> Map.values |> Enum.uniq
  end

  test "pids" do
    (1..2)
    |> Enum.map(fn i -> "T_#{i}" end)
    |> Enum.map(&TaskManager.start_task(&1, 3, "Project1"))
    states = TaskManager
             |> DynamicSupervisor.which_children()
             |> Enum.map(fn {_, pid, :worker, [TaskFSM]} -> pid end)
             |> Enum.map(&TaskFSM.state/1)
    assert [] != states
  end
end

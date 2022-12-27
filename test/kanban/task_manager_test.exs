defmodule TaskManagerTest do
  use ExUnit.Case
  doctest Kanban.TaskFSM
  doctest Kanban.TaskManager

  alias Kanban.{TaskFSM, TaskManager}

  test "check pid of DynamicSupervisor" do
    assert nil != Process.whereis(Kanban.TaskManager)
    assert nil != Process.whereis(Kanban.TaskRegistry)
  end

  test "start_task" do
    (1..2)
    |> Enum.map(&"T_#{&1}")
    |> Enum.map(&TaskManager.start_task(&1, 3, "Project1"))
    [{_, pid, _, _}, {_, _, _, _}] = DynamicSupervisor.which_children(Kanban.TaskManager)
    TaskFSM.start(pid)
    Process.exit(pid, :kill)
    Process.sleep(100)
    assert "idle" == TaskFSM.state({:via, Registry, {Kanban.TaskRegistry, "T_1"}})
    assert 2 == DynamicSupervisor.which_children(Kanban.TaskManager) |> Enum.count
  end
end

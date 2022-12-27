defmodule TaskFSMTest do
  use ExUnit.Case
  doctest Kanban.Data.Task
  doctest Kanban.TaskFSM

  alias Kanban.Data.Task
  alias Kanban.TaskFSM

  test "start_link task with idle state" do
    {:ok, pid} = Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "Task1"})
    state = GenServer.call(pid, :state)
    assert "idle" == state
  end

  test "start task with doing state" do
    {:ok, pid} = Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "Task1"})
    alias Kanban.TaskFSM, as: F
    F.start(pid)
    state = GenServer.call(pid, :state)
    assert "doing" == state
  end

  test "start task by registry" do
    {:ok, pid} = Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "Task1"})
    TaskFSM.start({:via, Registry, {Kanban.TaskRegistry, "Task1"}})
    assert "doing" == TaskFSM.state(pid)
  end

  test "finish task" do
    {:ok, pid} = Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "Task1"})
    Process.monitor(pid)
    TaskFSM.start(pid)
    TaskFSM.finish(pid)
    Process.sleep(100)
    assert false == Process.alive?(pid)
  end
end

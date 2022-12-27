defmodule KanbanTest do
  use ExUnit.Case
  doctest Kanban

  alias Kanban.Data.Task

  test "query_task" do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "T_1"})
    state = Kanban.query_task("T_1")
    assert "idle" == state
  end

  test "start_task" do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "T_1"})
    Kanban.start_task("T_1")
    state = Kanban.query_task("T_1")
    assert "doing" == state
  end

  test "finish_task" do
    {:ok, pid} = Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "T_1"})
    Kanban.start_task("T_1")
    Kanban.finish_task("T_1")
    Process.sleep(100)
    assert false == Process.alive?(pid)
  end
end

defmodule KanbanTest do
  use ExUnit.Case
  doctest Kanban

  alias Kanban.Data.Task

  test "query_task" do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "query_task"})
    state = Kanban.query_task("query_task")
    assert "idle" == state
  end

  test "start_task" do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "start_task"})
    Kanban.start_task("start_task")
    state = Kanban.query_task("start_task")
    assert "doing" == state
  end

  test "finish_task" do
    {:ok, pid} = Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "finish_task"})
    Kanban.start_task("finish_task")
    Kanban.finish_task("finish_task")
    Process.sleep(100)
    assert false == Process.alive?(pid)
  end
end

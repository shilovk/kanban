defmodule IssueFSMTest do
  use ExUnit.Case
  doctest Kanban.Data.Issue
  doctest Kanban.IssueFSM

  alias Kanban.Data.Issue

  test "start_link issue with idle state" do
    {:ok, pid} = Kanban.IssueFSM.start_link(%Issue{state: "idle", title: "Issue1"})
    state = GenServer.call(pid, :state)
    assert "idle" == state
  end

  test "start issue with doing state" do
    {:ok, pid} = Kanban.IssueFSM.start_link(%Issue{state: "idle", title: "Issue1"})
    alias Kanban.IssueFSM, as: F
    F.start(pid)
    state = GenServer.call(pid, :state)
    assert "doing" == state
  end

  # test "finish issue" do
  #   {:ok, pid} = Kanban.IssueFSM.start_link(%Issue{state: "idle", title: "Issue1"})
  #   IssueFSM.start(pid)
  #   IssueTaskFSM.finish(pid)
  #   assert false == Process.alive?(pid)
  # end
end

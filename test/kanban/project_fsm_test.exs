defmodule ProjectFSMTest do
  use ExUnit.Case
  doctest Kanban.Data.Project
  doctest Kanban.ProjectFSM

  alias Kanban.Data.Project

  test "start_link project" do
    {:ok, pid} = Kanban.ProjectFSM.start_link(%Project{title: "Project1"})
    assert true == Process.alive?(pid)
  end
end

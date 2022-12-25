defmodule DataProjectTest do
  use ExUnit.Case
  doctest Kanban.Data.Project

  alias Kanban.Data.Project

  test "changeset" do
    params = %{title: "Space travel", description: "What we must doing"}
    changeset = %Project{} |> Project.changeset(params)
    assert params == changeset.changes
  end

  test "create" do
    params = %{title: "Space travel", description: "What we must doing"}
    project = Project.create(params)
    assert params.title == project.title
    assert params.description == project.description
  end
end

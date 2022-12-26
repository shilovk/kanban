defmodule DataTaskTest do
  use ExUnit.Case
  doctest Kanban.Data.Task

  alias Kanban.Data.Task

  test "changeset" do
    params = %{title: "Task1", description: "Description1"}
    changeset = %Task{} |> Task.changeset(params)
    assert params == changeset.changes
  end

  test "create" do
    params = %{
      title: "Task1",
      due: DateTime.add(DateTime.utc_now(), 5, :day),
      description: "TakDescription1",
      project: %{title: "Space travel", description: "What we must doing"}
    }
    task = Task.create(params)
    assert params.title == task.title
    assert params.description == task.description
  end
end

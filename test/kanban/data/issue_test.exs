defmodule DataIssueTest do
  use ExUnit.Case
  doctest Kanban.Data.Issue

  alias Kanban.Data.Issue

  test "changeset" do
    params = %{title: "Issue1", description: "Question1"}
    changeset = %Issue{} |> Issue.changeset(params)
    assert params == changeset.changes
  end

  test "create" do
    params = %{
      title: "Issue1",
      description: "Question1",
      task: %{
        title: "Task1",
        due: DateTime.add(DateTime.utc_now(), 5, :day),
        description: "TakDescription1",
        project: %{title: "Space travel", description: "What we must doing"}
      }
    }
    issue = Issue.create(params)
    assert params.title == issue.title
    assert params.description == issue.description
  end

  #  test "start" do
  #    params = %{
  #      title: "Issue1",
  #      description: "Question1",
  #      task: %{
  #        title: "Task1",
  #        due: DateTime.add(DateTime.utc_now(), 5, :day),
  #        description: "TakDescription1",
  #        project: %{title: "Space travel", description: "What we must doing"}
  #      }
  #    }
  #    issue = Issue.create(params)
  #    Issue.start(issue)
  #    assert "doing" == issue.state
  #  end
end

defmodule DataUserTest do
  use ExUnit.Case
  doctest Kanban.Data.User

  alias Kanban.Data.User

  test "create_default" do
    user = User.create_default
    assert "am" == user.name
  end

  test "changeset" do
    params = %{name: "Jerry", password: "foo"}
    changeset = %User{} |> User.changeset(params)
    assert params == changeset.changes
  end

  test "create" do
    params = %{name: "Jerry", password: "foo"}
    user = User.create(params)
    assert params.name == user.name
  end
end

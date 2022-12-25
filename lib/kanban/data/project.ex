defmodule Kanban.Data.Project do
  use Ecto.Schema

  alias Kanban.Data.Project

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    # field :id, :binary_id, autogenerate: &Ecto.UUID.generate/0
    field :title, :string
    field :description, :string
    # has_many :tasks, Task
  end

  def changeset(project, params) do
    project
    |> cast(params, ~w[title description]a)
      # |> cast_assoc(:tasks, with: &Task.changeset/2)
    |> validate_required(~w[title]a)
  end

  def create(params) when is_list(params),
      do: params |> Map.new() |> create()

  def create(params) when is_map(params) do
    %Project{}
    |> changeset(params)
    |> case do
         %Ecto.Changeset{valid?: false, errors: errors} -> {:error, errors}
         changeset -> apply_changes(changeset)
       end
  end

  def create(title, description \\ nil) do
    create(
      title: title,
      description: description
    )
  end
end

defmodule Kanban.Data.Issue do
  use Ecto.Schema

  alias Kanban.Data.{Issue, Task}

  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    # field :id, :binary_id, autogenerate: &Ecto.UUID.generate/0
    field :title, :string
    field :description, :string
    field :state, :string, default: "idle"
    embeds_one :task, Task
    # belongs_to :task, Task
  end

  def changeset(issue, params) do
    issue
    |> cast(params, ~w[title description]a)
    |> cast_embed(:task, with: &Task.changeset/2)
    |> validate_required(~w[title]a)
    |> validate_inclusion(:state, ~w[idle doing done]a)
  end

  def create(params) when is_list(params),
      do: params |> Map.new() |> create()

  def create(params) when is_map(params) do
    %Issue{}
    |> changeset(params)
    |> case do
         %Ecto.Changeset{valid?: false, errors: errors} -> {:error, errors}
         changeset -> apply_changes(changeset)
       end
  end

  def create(title, project_title, task_title, task_due_days,
        description \\ nil, project_description \\ nil, task_description \\ nil) do
    create(
      title: title,
      description: description,
      task: %{
        title: task_title,
        due: DateTime.add(DateTime.utc_now(), task_due_days, :day),
        description: task_description,
        project: %{title: project_title, description: project_description},
      }
    )
  end
end

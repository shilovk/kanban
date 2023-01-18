defmodule Kanban do
  @moduledoc """
  Documentation for `Kanban`.
  """

  def start_task(task_name) do
    Kanban.TaskFSM.start({:via, Registry, {Kanban.TaskRegistry, task_name}})
  end

  def finish_task(task_name) do
    Kanban.TaskFSM.finish({:via, Registry, {Kanban.TaskRegistry, task_name}})
  end

  def query_task(task_name) do
    #if Process.alive?({:via, Registry, {Kanban.TaskRegistry, task_name}}) do
      Kanban.TaskFSM.state({:via, Registry, {Kanban.TaskRegistry, task_name}})
    #end
  end

  @doc """
  Hello world.

  ## Examples

      iex> Kanban.hello(true)
      :world
      iex> Kanban.hello(false)
      :sun

  """
  def hello(arg) do
    case arg do
      true -> :world
      false -> :sun
    end
  end
end

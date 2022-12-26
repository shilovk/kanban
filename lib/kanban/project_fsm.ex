defmodule Kanban.ProjectFSM do
  @moduledoc """
  Process to be run
  """

  alias Kanban.Data.Project

  use GenServer, restart: :transient

  require Logger

  def start_link(%Project{title: title} = project)
      when not is_nil(title) do
    GenServer.start_link(__MODULE__, project, name: __MODULE__)
  end

  @impl GenServer
  def init(state), do: {:ok, state}
end

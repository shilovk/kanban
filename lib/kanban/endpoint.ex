defmodule Kanban.Endpoint do
  use Plug.Router

  alias Kanban.Data.Task

  require Logger

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(message()))
  end

  defp message do
    %{
      response_type: "in_channel",
      text: "Kanban Tasks"
    }
  end

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  get "/query_task" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(query_task()))
  end

  get "/start_task" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(start_task()))
  end

  get "/finish_task" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(finish_task()))
  end

  match _ do
    send_resp(conn, 404, "Requested page not found!")
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    with {:ok, [port: port] = config} <- Application.fetch_env(:kanban, __MODULE__) do
      Logger.info("Starting server at http://localhost:#{port}/")
      Plug.Cowboy.http(__MODULE__, [], config)
    end
  end

  defp query_task do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "T_1"})
    Kanban.query_task("T_1")
  end

  defp start_task do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "T_1"})
    Kanban.start_task("T_1")
  end

  defp finish_task do
    Kanban.TaskFSM.start_link(task: %Task{state: "idle", title: "T_1"})
    Kanban.start_task("T_1")
    Kanban.finish_task("T_1")
  end
end
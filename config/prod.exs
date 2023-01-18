use Mix.Config

config :kanban, Kanban.Endpoint,
       port: "PORT" |> System.get_env() |> String.to_integer()
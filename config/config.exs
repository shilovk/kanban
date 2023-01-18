use Mix.Config

config :kanban, Kanban.Endpoint, port: 4000

import_config "#{Mix.env()}.exs"
# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_server,
  ecto_repos: [ApiServer.Repo]

# Configures the endpoint
config :api_server, ApiServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "maKUJZKEJmi9fgpgp/D0VKjJa2yheK40q4Eed+14peQr0zvy7c6z7X9elyGxNAgv",
  render_errors: [view: ApiServerWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ApiServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :api_server, ApiServerWeb.Guardian,
  issuer: "api_server",
  secret_key: "shlUujtCllEQx3DeFP+++7L0B3r5cUvs7zXEY++FN8arJdhaSlMxuyf8EE/rz80y",
  ttl: {1, :day}

# Store uploaded file in local storage
config :arc,
  storage: Arc.Storage.Local

# cors
config :cors_plug,
  origin: ["http://localhost:4200"],
  headers: ["*"],
  max_age: 86400,
  methods: ["GET", "POST"]

# 微信配置
config :api_server, ApiServerWeb.WechatController,
  app_id: "appidis123456"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

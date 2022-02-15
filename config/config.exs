# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :prevent, PreventWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i0shraLkTb9ji/aqMtbBPBLK5J7v9ciu8GDL1a/LPEKjb2RHZVc5gPnQlKhF4i9V",
  render_errors: [view: PreventWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Prevent.PubSub,
  live_view: [signing_salt: "xny7eMWy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :concertcare,
  ecto_repos: [Concertcare.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :concertcare, ConcertcareWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xoNMyIzfzp7kM7QIZIctk7ZvTGJlkfrGtZ/Rpl6zywZ/aYyc9LvdiC1c3iJrpWwX",
  render_errors: [view: ConcertcareWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Concertcare.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "uguOmr/G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

#Guardian Library for JWT Authentication
config :concertcare, ConcertcareWeb.Auth.Guardian,
       issuer: "concertcare",
       secret_key: "2Bc8S8IsA7z4IqCq1U4SFP8vvIl8WaD3m1DAvwrz1cyhlw6pHYpaePm+OgVXoTmI"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

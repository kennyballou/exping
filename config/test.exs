use Mix.Config

config :exping, http_client: ExPing.Test.HTTPClient

config :exping, :http,
  timeout: 10

config :logger, level: :warn

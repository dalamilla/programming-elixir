import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :exercise_tracker, ExerciseTracker.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "exercise_tracker_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :exercise_tracker, ExerciseTrackerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "dOTn2MBP9zqZ+P2IZ+JCkUQW8HauQnNaS0AeK++d239Hfw7rgd9f/EKTpL0nuXZJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

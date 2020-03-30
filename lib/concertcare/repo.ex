defmodule Concertcare.Repo do
  use Ecto.Repo,
    otp_app: :concertcare,
    adapter: Ecto.Adapters.Postgres
end

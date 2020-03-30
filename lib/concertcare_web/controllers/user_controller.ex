defmodule ConcertcareWeb.UserController do
  use ConcertcareWeb, :controller

  alias Concertcare.Accounts
  alias Concertcare.Accounts.User

  alias ConcertcareWeb.Auth.Guardian

  action_fallback ConcertcareWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
      {:ok, token, _claims} <- Guardian.encode_and_sign(user) do

      conn
      |> put_status(:created)
      |> render("user.json", user: user, token: token)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user, token: token)
    end
  end

end

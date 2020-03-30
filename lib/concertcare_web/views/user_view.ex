defmodule ConcertcareWeb.UserView do
  use ConcertcareWeb, :view
  alias ConcertcareWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, token: token}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end

  def render("delete.json", %{status: "ok"}) do
    %{
      status: "ok"
    }
  end
end

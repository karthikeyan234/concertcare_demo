defmodule ConcertcareWeb.PostController do
  use ConcertcareWeb, :controller

  alias Concertcare.Blog
  alias Concertcare.Blog.Post

  action_fallback ConcertcareWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def show_all(conn, %{"id" => id}) do
    posts = Blog.list_posts(id)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Blog.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{}} <- Blog.delete_post(post) do
      render(conn, "delete.json")
    end
  end
end

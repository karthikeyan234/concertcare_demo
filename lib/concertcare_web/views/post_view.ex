defmodule ConcertcareWeb.PostView do
  use ConcertcareWeb, :view
  alias ConcertcareWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      title: post.title,
      body: post.body}
  end
  def render("delete.json", _) do
    %{
      status: "ok"
    }
  end
end

defmodule Concertcare.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :body, :string
    field :title, :string
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do

    required_fields = [:title, :body, :user_id]
    
    post
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
  end
end

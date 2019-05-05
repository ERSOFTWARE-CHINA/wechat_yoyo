defmodule ApiServer.PostCommentContext.PostComment do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User
  alias ApiServer.PostContext.Post

  schema "post_comments" do
    field :content, :string
    field :date, :string

    belongs_to :users, User, on_replace: :nilify
    belongs_to :posts, Post, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(post_comment, attrs) do
    post_comment
    |> cast(attrs, [:content, :date])
    |> validate_required([:content])
  end
end

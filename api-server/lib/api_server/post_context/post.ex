defmodule ApiServer.PostContext.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.TechnicianContext.Technician
  alias ApiServer.PostImageContext.PostImage
  alias ApiServer.PostCommentContext.PostComment

  schema "posts" do
    field :title, :string
    field :date, :string
    field :good, :integer, default: 0
    field :content, :string
    belongs_to :technician, Technician, on_replace: :nilify
    has_many :post_images, PostImage, on_delete: :delete_all, on_replace: :delete
    has_many :post_comments, PostComment, on_delete: :delete_all, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :date, :good, :content])
    |> validate_required([:title])
  end
end

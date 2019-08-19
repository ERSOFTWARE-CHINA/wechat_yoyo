defmodule ApiServer.PostImageContext.PostImage do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.PostContext.Post

  schema "post_images" do
    field :image, ApiServer.PostImageImage.Type
    field :uuid, :string
    belongs_to :post, Post, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(post_comment, attrs) do
    post_comment
    |> cast(attrs, [])
    |> check_uuid
    |> cast_attachments(attrs, [:image])
  end

  defp check_uuid(changeset) do
    case get_field(changeset, :uuid) do
      nil ->
        force_change(changeset, :uuid, Ecto.UUID.generate)
      _ ->
        changeset
    end
  end
end

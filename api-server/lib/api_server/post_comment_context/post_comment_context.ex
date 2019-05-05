defmodule ApiServer.PostCommentContext do
  @moduledoc """
  The PostCommentContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.PostCommentContext.PostComment

  @doc """
  Returns the list of post_comments.

  ## Examples

      iex> list_post_comments()
      [%PostComment{}, ...]

  """
  def list_post_comments do
    Repo.all(PostComment)
  end

  @doc """
  Gets a single post_comment.

  Raises `Ecto.NoResultsError` if the Post comment does not exist.

  ## Examples

      iex> get_post_comment!(123)
      %PostComment{}

      iex> get_post_comment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post_comment!(id), do: Repo.get!(PostComment, id)

  @doc """
  Creates a post_comment.

  ## Examples

      iex> create_post_comment(%{field: value})
      {:ok, %PostComment{}}

      iex> create_post_comment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post_comment(attrs \\ %{}) do
    %PostComment{}
    |> PostComment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post_comment.

  ## Examples

      iex> update_post_comment(post_comment, %{field: new_value})
      {:ok, %PostComment{}}

      iex> update_post_comment(post_comment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post_comment(%PostComment{} = post_comment, attrs) do
    post_comment
    |> PostComment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PostComment.

  ## Examples

      iex> delete_post_comment(post_comment)
      {:ok, %PostComment{}}

      iex> delete_post_comment(post_comment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post_comment(%PostComment{} = post_comment) do
    Repo.delete(post_comment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post_comment changes.

  ## Examples

      iex> change_post_comment(post_comment)
      %Ecto.Changeset{source: %PostComment{}}

  """
  def change_post_comment(%PostComment{} = post_comment) do
    PostComment.changeset(post_comment, %{})
  end
end

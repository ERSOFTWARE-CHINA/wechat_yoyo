defmodule ApiServer.PostCommentContextTest do
  use ApiServer.DataCase

  alias ApiServer.PostCommentContext

  describe "post_comments" do
    alias ApiServer.PostCommentContext.PostComment

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def post_comment_fixture(attrs \\ %{}) do
      {:ok, post_comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PostCommentContext.create_post_comment()

      post_comment
    end

    test "list_post_comments/0 returns all post_comments" do
      post_comment = post_comment_fixture()
      assert PostCommentContext.list_post_comments() == [post_comment]
    end

    test "get_post_comment!/1 returns the post_comment with given id" do
      post_comment = post_comment_fixture()
      assert PostCommentContext.get_post_comment!(post_comment.id) == post_comment
    end

    test "create_post_comment/1 with valid data creates a post_comment" do
      assert {:ok, %PostComment{} = post_comment} = PostCommentContext.create_post_comment(@valid_attrs)
      assert post_comment.content == "some content"
    end

    test "create_post_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostCommentContext.create_post_comment(@invalid_attrs)
    end

    test "update_post_comment/2 with valid data updates the post_comment" do
      post_comment = post_comment_fixture()
      assert {:ok, %PostComment{} = post_comment} = PostCommentContext.update_post_comment(post_comment, @update_attrs)
      assert post_comment.content == "some updated content"
    end

    test "update_post_comment/2 with invalid data returns error changeset" do
      post_comment = post_comment_fixture()
      assert {:error, %Ecto.Changeset{}} = PostCommentContext.update_post_comment(post_comment, @invalid_attrs)
      assert post_comment == PostCommentContext.get_post_comment!(post_comment.id)
    end

    test "delete_post_comment/1 deletes the post_comment" do
      post_comment = post_comment_fixture()
      assert {:ok, %PostComment{}} = PostCommentContext.delete_post_comment(post_comment)
      assert_raise Ecto.NoResultsError, fn -> PostCommentContext.get_post_comment!(post_comment.id) end
    end

    test "change_post_comment/1 returns a post_comment changeset" do
      post_comment = post_comment_fixture()
      assert %Ecto.Changeset{} = PostCommentContext.change_post_comment(post_comment)
    end
  end
end

defmodule ApiServer.PostContextTest do
  use ApiServer.DataCase

  alias ApiServer.PostContext

  describe "posts" do
    alias ApiServer.PostContext.Post

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PostContext.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert PostContext.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert PostContext.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = PostContext.create_post(@valid_attrs)
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PostContext.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = PostContext.update_post(post, @update_attrs)
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = PostContext.update_post(post, @invalid_attrs)
      assert post == PostContext.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = PostContext.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> PostContext.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = PostContext.change_post(post)
    end
  end
end

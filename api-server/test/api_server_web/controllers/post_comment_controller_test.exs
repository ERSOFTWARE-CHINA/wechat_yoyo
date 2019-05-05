defmodule ApiServerWeb.PostCommentControllerTest do
  use ApiServerWeb.ConnCase

  alias ApiServer.PostCommentContext
  alias ApiServer.PostCommentContext.PostComment

  @create_attrs %{
    content: "some content"
  }
  @update_attrs %{
    content: "some updated content"
  }
  @invalid_attrs %{content: nil}

  def fixture(:post_comment) do
    {:ok, post_comment} = PostCommentContext.create_post_comment(@create_attrs)
    post_comment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all post_comments", %{conn: conn} do
      conn = get(conn, Routes.post_comment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create post_comment" do
    test "renders post_comment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.post_comment_path(conn, :create), post_comment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.post_comment_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.post_comment_path(conn, :create), post_comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update post_comment" do
    setup [:create_post_comment]

    test "renders post_comment when data is valid", %{conn: conn, post_comment: %PostComment{id: id} = post_comment} do
      conn = put(conn, Routes.post_comment_path(conn, :update, post_comment), post_comment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.post_comment_path(conn, :show, id))

      assert %{
               "id" => id,
               "content" => "some updated content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, post_comment: post_comment} do
      conn = put(conn, Routes.post_comment_path(conn, :update, post_comment), post_comment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete post_comment" do
    setup [:create_post_comment]

    test "deletes chosen post_comment", %{conn: conn, post_comment: post_comment} do
      conn = delete(conn, Routes.post_comment_path(conn, :delete, post_comment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.post_comment_path(conn, :show, post_comment))
      end
    end
  end

  defp create_post_comment(_) do
    post_comment = fixture(:post_comment)
    {:ok, post_comment: post_comment}
  end
end

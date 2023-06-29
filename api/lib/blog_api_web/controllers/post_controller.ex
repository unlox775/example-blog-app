defmodule BlogApiWeb.PostController do
  use BlogApiWeb, :controller

  alias BlogApi.Blog

  def index(conn, _params) do
    posts = Blog.list_posts() |> Enum.map(&Blog.post_to_map/1)
    json(conn, posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id) |> Blog.post_to_map()
    json(conn, post)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, post} <- Blog.create_post(post_params) do
      conn
      |> put_status(:created)
      |> Blog.post_to_map()
      |> json(post)
    else
      _ -> conn |> put_status(:unprocessable_entity) |> json(%{error: "Unable to create post"})
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id) |> Blog.post_to_map()

    with {:ok, post} <- Blog.update_post(post, post_params) do
      json(conn, post)
    else
      _ -> conn |> put_status(:unprocessable_entity) |> json(%{error: "Unable to update post"})
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)

    with {:ok, _post} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    else
      _ -> conn |> put_status(:unprocessable_entity) |> json(%{error: "Unable to delete post"})
    end
  end
end

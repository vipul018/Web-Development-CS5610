defmodule Tasktracker2Web.SessionController do
  use Tasktracker2Web, :controller

  alias Tasktracker2.Accounts

  def create(conn, %{"email" => email }) do
    user = Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back #{user.name}")
      |>redirect(to: user_path(conn, :show, user))
    else
      conn
      |> put_flash(:error, "Can't create session")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end

  def task_create(conn,%{ "task_id" => task_id }) do
    conn
    |> put_session(:task_id, task_id)
    |> redirect(to: sprintcycle_path(conn, :new))
  end

end

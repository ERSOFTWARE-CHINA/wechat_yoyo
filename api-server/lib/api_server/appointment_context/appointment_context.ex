defmodule ApiServer.AppointmentContext do
  @moduledoc """
  The AppointmentContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.AppointmentContext.Appointment
  alias ApiServer.UserContext.User
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.AppointmentContext
      use ApiServer.BaseContext
      alias ApiServer.AppointmentContext.Appointment
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(wechat_openid: open_id)
    Appointment
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "status")
    |> get_pagination(params)
  end

  def page(params) do 
    Appointment
    |> query_equal(params, "status")
    |> query_order_desc_by(params, "date")
    |> get_pagination(params)
  end

end

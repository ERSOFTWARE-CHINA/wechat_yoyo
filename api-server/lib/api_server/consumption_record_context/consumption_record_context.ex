defmodule ApiServer.ConsumptionRecordContext do
  @moduledoc """
  The ConsumptionRecordContext context.
  """

  import Ecto.Query, warn: false
  alias ApiServer.Repo

  alias ApiServer.UserContext.User
  alias ApiServer.ConsumptionRecordContext.ConsumptionRecord
  use ApiServer.BaseContext

  defmacro __using__(_opts) do
    quote do
      import ApiServer.ConsumptionRecordContext
      use ApiServer.BaseContext
      alias ApiServer.ConsumptionRecordContext.ConsumptionRecord
    end
  end

  def page(%{"openid" => open_id} = params) do
    {:ok, user} = User
    |> get_by_name(wechat_openid: open_id)
    ConsumptionRecord
    |> query_equal(%{"user_id" => user.id}, "user_id")
    |> query_equal(params, "type")
    |> query_order_desc_by(params, "datetime")
    |> get_pagination(params)
  end

  def page(params) do 
    ConsumptionRecord
    |> query_equal(params, "type")
    |> query_order_desc_by(params, "datetime")
    |> get_pagination(params)
  end

end
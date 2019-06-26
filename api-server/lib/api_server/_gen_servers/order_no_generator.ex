defmodule ApiServer.MicroService.OrderNoGenerator do

@moduledoc """
自动生成订单号的服务
"""
    
  use GenServer
  alias ApiServer.OrderContext
  alias ApiServer.VipOrderContext
  alias ApiServer.ServiceOrderContext
  alias ApiServer.Utils.NoGenerator

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: OrderNoGenerator)
  end
  
  # 生成产品购买订单号
  def handle_call(:get_no, _from, state) do
    state
    |> Map.get(:order_no)
    |> case do
      nil ->
        current_no = OrderContext.get_current_order_no()
        {:ok, next_no}  = current_no |> NoGenerator.get_next_no
        new_state = state
        |> Map.put_new(:order_no, next_no)
        {:reply, next_no, new_state}
      {:ok, value} -> 
        {:ok, next_no}  = value |> NoGenerator.get_next_no
        new_state = state
        |> Map.update!(:order_no, fn _ -> next_no end)
        {:reply, next_no, new_state}
    end
  end

  # 生成vip购买订单号
  def handle_call(:get_vip_order_no, _from, state) do
    # IO.puts inspect state|> Map.get(:vip_order_no)
    state
    |> Map.get(:vip_order_no)
    |> case do
      nil ->
        current_no = VipOrderContext.get_current_order_no()
        {:ok, next_no} = current_no |> NoGenerator.get_next_no
        new_state = state
        |> Map.put_new(:vip_order_no, next_no)
        IO.puts "##### nil ######"
        IO.puts inspect next_no
        IO.puts inspect new_state
        {:reply, next_no, new_state}
      value -> 
        {:ok, next_no}  = value |> NoGenerator.get_next_no
        new_state = state
        |> Map.update!(:vip_order_no, fn _ -> next_no end)
        IO.puts "##### value ######"
        IO.puts inspect next_no
        {:reply, next_no, new_state}
    end
  end

  # 生成服务购买订单号
  def handle_call(:get_service_order_no, _from, state) do
    state
    |> Map.get(:service_order_no)
    |> case do
      nil ->
        current_no = ServiceOrderContext.get_current_order_no()
        {:ok, next_no}  = current_no |> NoGenerator.get_next_no
        new_state = state
        |> Map.put_new(:service_order_no, next_no)
        {:reply, next_no, new_state}
      {:ok, value} -> 
        {:ok, next_no}  = value |> NoGenerator.get_next_no
        new_state = state
        |> Map.update!(:service_order_no, fn _ -> next_no end)
        {:reply, next_no, new_state}
    end
  end

end
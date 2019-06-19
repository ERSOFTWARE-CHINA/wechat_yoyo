defmodule ApiServerWeb.ConsumptionRecordView do
  use ApiServerWeb, :view
  alias ApiServerWeb.ConsumptionRecordView

  def render("index.json", %{page: page}) do
    %{
      data: render_many(page.entries, ConsumptionRecordView, "consumption_record.json"),
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }
  end

  def render("show.json", %{consumption_record: consumption_record}) do
    %{data: render_one(consumption_record, ConsumptionRecordView, "consumption_record.json")}
  end

  def render("consumption_record.json", %{consumption_record: consumption_record}) do
    %{
      id: consumption_record.id,
      name: consumption_record.name,
      pay_type: consumption_record.pay_type,
      type: consumption_record.type,
      amount: consumption_record.amount,
      datetime: consumption_record.datetime
    }
  end
end

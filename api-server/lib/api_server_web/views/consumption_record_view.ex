defmodule ApiServerWeb.ConsumptionRecordView do
  use ApiServerWeb, :view
  alias ApiServerWeb.ConsumptionRecordView

  def render("index.json", %{consumption_records: consumption_records}) do
    %{data: render_many(consumption_records, ConsumptionRecordView, "consumption_record.json")}
  end

  def render("show.json", %{consumption_record: consumption_record}) do
    %{data: render_one(consumption_record, ConsumptionRecordView, "consumption_record.json")}
  end

  def render("consumption_record.json", %{consumption_record: consumption_record}) do
    %{id: consumption_record.id,
      type: consumption_record.type}
  end
end

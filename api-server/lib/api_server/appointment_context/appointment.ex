defmodule ApiServer.AppointmentContext.Appointment do
  use Ecto.Schema
  import Ecto.Changeset
  alias ApiServer.UserContext.User
  alias ApiServer.TechnicianContext.Technician
  alias ApiServer.ServiceContext.Service

  schema "appointments" do
    field :date, :string #预约日期
    field :time, :string #预约时间段
    field :status, :string #状态
    belongs_to :user, User, on_replace: :nilify
    belongs_to :technician, Technician, on_replace: :nilify
    belongs_to :service, Service, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:date, :time, :status])
    |> validate_required([:date])
  end
end

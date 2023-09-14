defmodule TodoApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TodoApp.Accounts.User

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :priority, :integer
    field :deadline, :utc_datetime
    field :completed, :boolean, default: false

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def insert_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :priority, :deadline, :user_id])
    |> validate_required([:title, :priority])
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :priority, :deadline, :user_id])
  end
end

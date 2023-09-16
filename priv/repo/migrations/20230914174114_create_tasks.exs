defmodule TodoApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration
  alias TodoApp.Accounts.User

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text
      add :priority, :integer, null: false
      add :deadline, :utc_datetime
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end
  end
end

defmodule TodoApp.TasksTest do
  use TodoApp.DataCase

  alias TodoApp.Tasks
  alias TodoApp.Tasks.Task

  setup do
    task = %{
      title: "Complete Feature X",
      priority: 1
    }

    {:ok, task: insert(:task, task)}
  end

  describe "fetch_tasks" do
    test "fetch all tasks - without filter", %{task: task} do
      tasks = Tasks.fetch_tasks()
      assert List.first(tasks) |> Map.get(:id) == task.id
    end
  end

  describe "create_task/1" do
    test "persist task - valid changeset" do
      deadline = DateTime.utc_now() |> DateTime.add(10, :day)

      attrs = %{
        title: "Create Background Job",
        description: "Desc for task",
        priority: 2,
        deadline: deadline
      }

      {:ok, task} = Tasks.create_task(attrs)
      assert task.title == attrs.title
    end

    test "persist task - invalid changeset" do
      attrs = %{
        title: "Create Background Job",
        description: "Desc for task"
      }

      {:error, cs} = Tasks.create_task(attrs)
      assert cs.errors == [priority: {"can't be blank", [validation: :required]}]
    end
  end

  describe "update_task/2" do
    test "update task - valid changeset", %{task: task} do
      attrs = %{
        description: "Description Feature X"
      }

      {:ok, updated_task} = Tasks.update_task(task, attrs)
      assert updated_task.description == attrs.description
    end

    test "update task - invalid changeset", %{task: task} do
      attrs = %{
        priority: "low"
      }

      {:error, cs} = Tasks.update_task(task, attrs)
      assert cs.errors == [priority: {"is invalid", [type: :integer, validation: :cast]}]
    end
  end

  describe "delete_task/1" do
    test "delete task - ok case", %{task: task} do
      {:ok, _} = Tasks.delete_task(task)
      refute Repo.get(Task, task.id)
    end
  end
end

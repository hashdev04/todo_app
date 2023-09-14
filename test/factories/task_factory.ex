defmodule TodoApp.TaskFactory do
  defmacro __using__(_opts) do
    quote do
      def task_factory do
        %TodoApp.Tasks.Task{
          title: "Example body"
        }
      end
    end
  end
end

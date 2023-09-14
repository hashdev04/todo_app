defmodule TodoApp.Factory do
  use ExMachina.Ecto, repo: TodoApp.Repo
  use TodoApp.TaskFactory
end

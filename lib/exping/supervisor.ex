defmodule ExPing.Supervisor do
  use Supervisor

  @moduledoc """
  ExPing Supervision Tree
  """

  @spec start_link :: {:ok, pid} | {:error, any}
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  @spec init(any) :: no_return
  def init(_) do
    children = [
    ]

    supervise(children, strategy: :one_for_one, name: __MODULE__)
  end
end

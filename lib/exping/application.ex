defmodule ExPing.Application do
  use Application
  @moduledoc """
  Application definition for ExPing
  """

  @doc """
  Start ExPing OTP Application
  """
  @spec start(any, any) :: {:ok, pid} | {:error, any}
  def start(_, _) do
    ExPing.Supervisor.start_link()
  end
end

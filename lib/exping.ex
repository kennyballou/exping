defmodule ExPing do
  require Logger
  @moduledoc """
  Public API for ExPing
  """

  @pings [&ExPing.HTTP.get/1, &ExPing.HTTP.head/1]

  @spec ping(URI.t) :: boolean
  def ping(address) do
    :ok = Logger.info("Attempting to ping #{inspect(address)}")
    @pings
      |> Enum.map(&spawn_ping(&1, address))
      |> Enum.all?
  end

  @spec spawn_ping(fun, URI.t) :: boolean
  defp spawn_ping(ping, address) do
    case ping.(address) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

end

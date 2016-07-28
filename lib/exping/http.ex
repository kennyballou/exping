defmodule ExPing.HTTP do
  require Logger
  @moduledoc """
  Provides basic HTTP client for pinging endpoints
  """

  @timeout Application.get_env(:exping, :http)[:timeout] || 5000

  @spec head(URI.t) :: {:ok, {integer, binary}} | {:error, term}
  def head(endpoint) do
    ref = make_ref()
    :ok = Logger.info("Sending HEAD request to #{inspect(endpoint)}")
    {:ok, _} = spawn_http_task(:head, [endpoint, ref, self()])

    receive do
      {:http_task_resp, ^ref, {:ok, {_, _}} = resp} -> resp
      {:http_task_resp, ^ref, {:error, _} = error} -> error
      after @timeout ->
        {:error, :timeout}
    end
  end

  @spec get(URI.t) :: {:ok, {integer, binary}} | {:error, term}
  def get(endpoint) do
    ref = make_ref()
    :ok = Logger.info("Sending GET request to #{inspect(endpoint)}")
    {:ok, _} = spawn_http_task(:get, [endpoint, ref, self()])

    receive do
      {:http_task_resp, ^ref, {:ok, _} = resp} -> resp
      {:http_task_resp, ^ref, {:error, _} =  error} -> error
      after @timeout ->
        {:error, :timeout}
    end
  end

  defp spawn_http_task(method, args) do
    Task.Supervisor.start_child(
      ExPing.Supervisor.Task,
      ExPing.HTTP.Task,
      method,
      args)
  end

end

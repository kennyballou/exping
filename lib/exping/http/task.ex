defmodule ExPing.HTTP.Task do
  require Logger
  @moduledoc """
  Task module for performing HTTP requests
  """

  @user_agent {'user-agent', 'exping'}

  @http Application.get_env(:exping, :http_client) || :httpc

  @type response :: {integer, binary}

  @spec head(URI.t, reference, pid) :: {:ok, response} | {:error, term}
  def head(%URI{} = uri, ref, owner) do
    :head
      |> @http.request({endpoint(uri), headers()}, [], [])
      |> process_response(ref, owner)
  end

  @spec get(URI.t, reference, pid) :: {:ok, response} | {:error, term}
  def get(%URI{} = uri, ref, owner) do
    :get
      |> @http.request({endpoint(uri), headers()}, [], [])
      |> process_response(ref, owner)
  end

  defp process_response({:ok, {{_, code, _}, _, body}}, ref, owner) do
    :ok = Logger.info("HTTP request returned: #{code}")
    send(owner, {:http_task_resp, ref, {:ok, {code, body}}})
  end

  defp process_response({:error, _} = error, ref, owner) do
    :ok = Logger.warn("HTTP request returned error: #{inspect(error)}")
    send(owner, {:http_task_resp, ref, error})
  end

  defp endpoint(%URI{} = uri) do
    uri |> to_string() |> String.to_charlist
  end

  defp headers do
    [@user_agent]
  end

end

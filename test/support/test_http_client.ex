defmodule ExPing.Test.HTTPClient do
  @moduledoc """
  Mock HTTP client provides interface similar to `:httpc`.
  """

  def request(url), do: request(:get, {url, []}, [], [])
  def request(:head, {url, _}, _, _) do
    cond do
      String.contains?(to_string(url), "/200") ->
        {:ok, {status_line(200), [], []}}
      String.contains?(to_string(url), "/405") ->
        {:ok, {status_line(405), [], []}}
      String.contains?(to_string(url), "/500") ->
        Process.exit(self, :kill)
      String.contains?(to_string(url), "/timeout") ->
        :timer.sleep(20)
        {:ok, {status_line(500), [], []}}
      true ->
        {:ok, {status_line(404), [], []}}
    end
  end
  def request(:get, {url, _}, _, _) do
    cond do
      String.contains?(to_string(url), "/200") ->
        {:ok, {status_line(200), [], []}}
      String.contains?(to_string(url), "/400") ->
        {:ok, {status_line(400), [], []}}
      String.contains?(to_string(url), "/500") ->
        Process.exit(self, :kill)
      String.contains?(to_string(url), "/timeout") ->
        :timer.sleep(20)
        {:ok, {status_line(500), [], []}}
      true ->
        {:ok, {status_line(404), [], []}}
    end
    {:ok, {status_line(404), [], []}}
  end

  for {code, reason} <- [{200, 'OK'},
                         {400, 'Bad Request'},
                         {404, 'Not Found'},
                         {405, 'Method Not Allowed'},
                         {500, 'Internal Server Error'}] do
    defp status_line(unquote(code)) do
      {'HTTP/1.1', unquote(code), unquote(reason)}
    end
  end
end

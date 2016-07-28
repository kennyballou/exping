defmodule ExPing.HTTP.Test do
  use ExUnit.Case

  describe "head requests" do
    test "can get ok response" do
      for code <- [200, 405] do
        {:ok, _} = ExPing.HTTP.head(URI.parse("localhost/#{code}"))
      end
    end

    test "can get error response" do
      {:error, _} = ExPing.HTTP.head(URI.parse("localhost/500"))
    end

    test "can get timeout response" do
      {:error, :timeout} = ExPing.HTTP.head(URI.parse("localhost/timeout"))
    end
  end

  describe "get requests" do
    test "can get ok response" do
      for code <- [200, 400, 404] do
        {:ok, _} = ExPing.HTTP.get(URI.parse("localhost/#{code}"))
      end
    end

    test "can get error response" do
      {:error, _} = ExPing.HTTP.get(URI.parse("localhost/500"))
    end

    test "can get timeout response" do
      {:error, :timeout} = ExPing.HTTP.get(URI.parse("localhost/timeout"))
    end
  end

end

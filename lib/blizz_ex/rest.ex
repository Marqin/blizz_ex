defmodule BlizzEx.Rest do

  def get(path, opts) do
    Application.get_env(:blizz_ex, :url) <> path
    |> HTTPoison.get([], [params: setopts(opts)])
    |> parse()
  end

  defp setopts(opts) do
    Map.put(opts, :locale, Application.get_env(:blizz_ex, :locale))
    |> Map.put(:apikey, Application.get_env(:blizz_ex, :apikey))
  end

  defp parse(api_response) do
    case api_response do
      {:ok, response } ->
        case Poison.decode(response.body) do
          {:ok, data} -> {:ok, data}
          {:error, message} -> {:error, {:poison, message}}
        end
      {:error, message} -> {:error, {:httpoison, message}}
    end
  end
end

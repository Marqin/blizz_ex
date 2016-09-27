defmodule BlizzEx.Rest do

  def get(path, opts) do
    url = Application.get_env(:blizz_ex, :url) <> path
    opts = setopts(opts)
    parse(HTTPoison.get(url, [], [params: opts]))
  end

  defp setopts(opts) do
    opts = Map.put(opts, :locale, Application.get_env(:blizz_ex, :locale))
    opts = Map.put(opts, :apikey, Application.get_env(:blizz_ex, :apikey))
  end

  defp parse(httpoison_return) do
    case httpoison_return do
      {:ok, response } ->
        case Poison.decode(response.body) do
          {:ok, data} -> {:ok, data}
          {:error, _} -> {:error, :poison}
        end
      {:error, _} -> {:error, :httpoison}
    end
  end
end

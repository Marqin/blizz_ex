defmodule BlizzEx.WoW.Guild do

  @prefix "/wow/guild/"

  def get(realm, name, opts) do
    BlizzEx.Rest.get(@prefix <> realm <> "/" <> name, %{fields: opts})
  end
end

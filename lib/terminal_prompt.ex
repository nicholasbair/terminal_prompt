defmodule TerminalPrompt do
  @moduledoc """
  Simple terminal script to demo Nylas smart compose with an event stream.
  """

  def start do
    fun = fn {:data, data}, {req, resp} ->
      data
      |> String.split("data: ")
      |> Enum.filter(fn x -> x != "" end)
      |> Enum.map(&Poison.decode!(&1))
      |> Enum.reduce("", fn x, acc -> acc <> Map.get(x, "suggestion") end)
      |> IO.write()

      {:cont, {req, resp}}
    end

    prompt = IO.gets("Enter a prompt: ")

    {:ok, _res} = ExNylas.SmartCompose.create_stream(
      %ExNylas.Connection{
        grant_id: "",
        api_key: ""
      },
      prompt,
      fun
    )
  end
end

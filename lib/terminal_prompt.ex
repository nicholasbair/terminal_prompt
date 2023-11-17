defmodule TerminalPrompt do
  def start do
    {:ok, pid} = GenServer.start_link(TerminalPrompt.StreamHandler, nil)

    prompt = IO.gets("Enter a prompt: ")

    {:ok, _res} = ExNylas.SmartCompose.create_stream(
      %ExNylas.Connection{
        grant_id: "",
        api_key: ""
      },
      prompt,
      pid
    )
  end
end

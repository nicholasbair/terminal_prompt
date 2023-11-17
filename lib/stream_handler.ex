defmodule TerminalPrompt.StreamHandler do
  require Logger
  use GenServer

  def start_link(prompt) do
    GenServer.start_link(__MODULE__, prompt, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, ""}
  end

  @impl true
  def handle_info(%HTTPoison.AsyncStatus{code: 200} = _request, state) do
    Logger.info("Received 200 response")
    {:noreply, state}
  end

  def handle_info(%HTTPoison.AsyncStatus{code: code} = _request, state) do
    {:stop, "Received non-200 response: #{inspect code}", state}
  end

  def handle_info(%HTTPoison.AsyncChunk{chunk: chunk} = _request, state) do
    joined =
      chunk
      |> String.split("data: ")
      |> Enum.filter(fn x -> x != "" end)
      |> Enum.map(&Poison.decode!(&1))
      |> Enum.reduce("", fn x, acc -> acc <> Map.get(x, "suggestion") end)

    new_state = state <> joined

    IO.write joined

    {:noreply, new_state}
  end

  # End of stream, clear state
  def handle_info(%HTTPoison.AsyncEnd{} = _request, _state) do
    {:noreply, ""}
  end

  def handle_info(_request, state) do
    {:noreply, state}
  end
end

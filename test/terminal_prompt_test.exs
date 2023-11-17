defmodule TerminalPromptTest do
  use ExUnit.Case
  doctest TerminalPrompt

  test "greets the world" do
    assert TerminalPrompt.hello() == :world
  end
end

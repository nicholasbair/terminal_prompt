defmodule TerminalPrompt.MixProject do
  use Mix.Project

  def project do
    [
      app: :terminal_prompt,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_nylas, git: "https://github.com/nicholasbair/ex_nylas.git", branch: "main"},
      {:poison, "~> 5.0"},
    ]
  end
end

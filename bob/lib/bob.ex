defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      shouting?(input) and questioning?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      questioning?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  defp questioning?(input) do
    String.ends_with?(String.trim(input), "?")
  end

  defp shouting?(input) do
    String.upcase(input) == input && Regex.match?(~r/\p{L}+/, input)
  end
end

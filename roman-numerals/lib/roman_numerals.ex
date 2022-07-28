defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """

  @roman_values [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @spec numeral(pos_integer) :: String.t()
  def numeral(0) do
    ""
  end

  def numeral(number) do
    @roman_values
    |> Enum.find(fn({arabic, _roman}) -> number >= arabic end)
    |> fn({arabic, roman}) ->
      roman <> numeral(number - arabic)
    end.()
  end
end

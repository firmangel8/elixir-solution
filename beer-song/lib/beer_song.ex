defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  @spec verse(integer) :: String.t()
  def verse(number) do
    {current_bottles, next_bottles, instruction} = bottle_terms(number)
    "#{String.capitalize(current_bottles)} of beer on the wall, #{current_bottles} of beer.\n#{instruction}, #{next_bottles} of beer on the wall.\n"
  end
  defp bottle_terms(number) do
    {bottle_term(number), bottle_term(number - 1), instruction_term(number)}
  end
  defp bottle_term(n) when n == -1, do: "99 bottles"
  defp bottle_term(n) when n == 0, do: "no more bottles"
  defp bottle_term(n) when n == 1, do: "1 bottle"
  defp bottle_term(n), do: "#{n} bottles"
  defp instruction_term(n) when n == 0, do: "Go to the store and buy some more"
  defp instruction_term(n) when n == 1, do: "Take it down and pass it around"
  defp instruction_term(_n), do: "Take one down and pass it around"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.map_join(range, "\n", &verse(&1))
  end
end

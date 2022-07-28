defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Enum.reduce([3, 5, 7], "", fn x, acc ->
      acc <> prime_factor(number, x)
    end)
    |> case do
      "" -> "#{number}"
      res -> res
    end
  end

  def prime_factor(n, 3) when rem(n, 3) == 0, do: "Pling"
  def prime_factor(n, 5) when rem(n, 5) == 0, do: "Plang"
  def prime_factor(n, 7) when rem(n, 7) == 0, do: "Plong"
  def prime_factor(_, _), do: ""
end

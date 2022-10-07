defmodule GuessingGame do
  def compare(secret_number, guess) when secret_number == guess, do: "Correct"
  def compare(_secret_nunber, guess) when is_atom(guess) == true, do: "Make a guess"
  def compare(secret_number, guess) when secret_number + 1 == guess, do: "So close"
  def compare(secret_number, guess) when secret_number - 1 == guess, do: "So close"
  def compare(secret_number, guess) when secret_number < guess, do: "Too high"
  def compare(secret_number, guess) when secret_number > guess, do: "Too low"
  def compare(_secret_number), do: "Make a guess"
end

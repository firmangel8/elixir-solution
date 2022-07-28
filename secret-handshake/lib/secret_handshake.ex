defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> handshake(code &&& 0b00001)
    |> handshake(code &&& 0b00010)
    |> handshake(code &&& 0b00100)
    |> handshake(code &&& 0b01000)
    |> handshake(code &&& 0b10000)
  end

  def handshake(actions, 0b00001), do: actions ++ ["wink"]
  def handshake(actions, 0b00010), do: actions ++ ["double blink"]
  def handshake(actions, 0b00100), do: actions ++ ["close your eyes"]
  def handshake(actions, 0b01000), do: actions ++ ["jump"]
  def handshake(actions, 0b10000), do: Enum.reverse(actions)
  def handshake(actions, _), do: actions
end

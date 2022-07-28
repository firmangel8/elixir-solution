defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:
      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """

  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    {hour, minute} = norm_time(hour, minute)
    %__MODULE__{hour: hour, minute: minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    {hour, minute} = norm_time(hour, minute + add_minute)
    %__MODULE__{hour: hour, minute: minute}
  end

  defp norm_time(hour, minute) do
    add_hour = floor(minute / 60)
    minute = Integer.mod(minute, 60)
    hour = Integer.mod(hour + add_hour, 24)
    {hour, minute}
  end
end

defimpl String.Chars, for: Clock do
  def to_string(clock) do
    "#{pad(clock.hour)}:#{pad(clock.minute)}"
  end

  defp pad(i) do
    "#{i}" |> String.pad_leading(2, "0")
  end
end

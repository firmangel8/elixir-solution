defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """

  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    new_datetime = DateTime.new!(Date.new!(year, month, day), Time.new!(hours, minutes, seconds))
    |> DateTime.add(1_000_000_000)
    new_date = DateTime.to_date(new_datetime)
    new_time = DateTime.to_time(new_datetime)
    {{new_date.year, new_date.month, new_date.day}, {new_time.hour, new_time.minute, new_time.second}}
  end
end

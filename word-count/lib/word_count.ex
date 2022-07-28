defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> ignore_punctuation()
    |> split_on_whitespaces()
    |> Enum.reduce(%{}, &update_counter/2)
  end

  defp update_counter(key, counter) do
    key =
      case key =~ ~r/^'.*'$/ do
        true -> String.replace(key, "'", "")
        _ -> key
      end
    count = Map.get(counter, key, 0)
    Map.put(counter, key, count + 1)
  end

  defp split_on_whitespaces(sentence) do
    String.split(sentence, ~r/\s/, trim: true)
  end

  defp ignore_punctuation(sentence) do
    String.replace(sentence, ~r/[!&@$%^,.;:_]/, " ")
  end

end

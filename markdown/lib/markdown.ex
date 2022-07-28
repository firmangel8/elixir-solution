defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.
    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.join()
    |> parse_list_and_wrap_with_html()
  end

  defp parse_line(line), do: do_parse_line(line)
  defp do_parse_line("#######" <> _ = line), do: enclose_with_paragraph_tag(String.split(line))
  defp do_parse_line("#" <> _ = line), do: parse_header_and_convert_to_html(line)
  defp do_parse_line("*" <> line), do: parse_list_and_convert_to_html(line)
  defp do_parse_line(line), do: enclose_with_paragraph_tag(String.split(line))
  defp parse_header_and_convert_to_html(header_md) do
    [h | t] = String.split(header_md)
    "<h" <> to_string(String.length(h)) <> ">" <> Enum.join(t, " ") <> "</h" <> to_string(String.length(h)) <> ">"
  end

  defp parse_list_and_convert_to_html(list_md) do
    tokens = String.split(String.trim_leading(list_md, "* "))
    "<li>#{
      tokens
      |> Enum.map(&replace_md_with_tag/1)
      |> Enum.join(" ")
    }</li>"
  end

  defp enclose_with_paragraph_tag(line) do
    "<p>#{
      line
      |> Enum.map(&replace_md_with_tag/1)
      |> Enum.join(" ")
    }</p>"
  end

  defp replace_md_with_tag(token) do
    token
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(token) do
    cond do
      token =~ ~r/^#{"__"}{1}/ -> String.replace(token, ~r/^#{"__"}{1}/, "<strong>", global: false)
      token =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(token, ~r/_/, "<em>", global: false)
      true -> token
    end
  end

  defp replace_suffix_md(token) do
    cond do
      token =~ ~r/#{"__"}{1}$/ -> String.replace(token, ~r/#{"__"}{1}$/, "</strong>")
      token =~ ~r/[^#{"_"}{1}]/ -> String.replace(token, ~r/_/, "</em>")
      true -> token
    end
  end

  defp parse_list_and_wrap_with_html(list) do
    String.replace(list, "<li>", "<ul>" <> "<li>", global: false)
    |> String.reverse()
    |> String.replace(String.reverse("</li>"), String.reverse("</li></ul>"), global: false)
    |> String.reverse()
  end
end

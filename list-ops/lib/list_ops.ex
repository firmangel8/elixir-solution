defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.
  @spec count(list) :: non_neg_integer
  def count(l), do: count(l, 0)
  defp count([], acc), do: acc
  defp count([_x | xs], acc), do: count(xs, 1 + acc)

  @spec reverse(list) :: list
  def reverse(list), do: reverse(list, [])

  defp reverse([], reversed_list), do: reversed_list
  defp reverse([x | xs], rl), do: reverse(xs, [x | rl])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: map(l, [], f)

  defp map([], acc, _f), do: reverse(acc)
  defp map([x | xs], acc, f), do: map(xs, [f.(x) | acc], f)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, p), do: filter(l, [], p)

  defp filter([], acc, _p), do: reverse(acc)
  defp filter([x | xs], acc, p) do
    if p.(x) do
      filter(xs, [x | acc], p)
    else
      filter(xs, acc, p)
    end
  end

  @type acc :: any

  @spec foldl(list, acc, (any, acc -> acc)) :: acc

  def foldl([], acc, _f), do: acc
  def foldl([x | xs], acc, f), do: foldl(xs, f.(x, acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, _f), do: acc
  def foldr([x | xs], acc, f), do: f.(x, foldr(xs, acc, f))

  @spec append(list, list) :: list
  def append(xs, ys), do: _append(reverse(xs), ys)

  defp _append([], ys), do: ys
  defp _append([x | xs], ys), do: _append(xs, [x | ys])

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([xs | xss]), do: append(xs, concat(xss))
end

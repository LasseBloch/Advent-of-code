defmodule Dec3 do
  defp calc_priority(items) do
    items
    |> get_common_item
    |> calc_priority_item
  end

  # worst hack ever!? But hey I'm using a MapSet, and reduce 😎 (fiiirst)
  defp get_common_item(strings) do
    strings
    |> Enum.map(&MapSet.new(to_charlist(&1)))
    |> Enum.reduce(nil, fn set, acc ->
      if(acc == nil, do: set, else: MapSet.intersection(acc, set))
    end)
    |> MapSet.to_list()
    |> List.first()
  end

  defp calc_priority_item(item) do
    if item > ?Z do
      item - (?a - 1)
    else
      item - (?A - 27)
    end
  end

  def part_1(rucksacks) do
    rucksacks
    |> String.split("\n", trim: true)
    |> Enum.map(& String.split_at(&1, div(String.length(&1), 2)) |> Tuple.to_list())
    |> Enum.map(&calc_priority/1)
    |> Enum.sum()
  end

  def part_2(rucksacks) do
    rucksacks
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&calc_priority/1)
    |> Enum.sum()
  end
end

test_input = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

Dec3.part_1(test_input) |> IO.inspect(label: "part 1 test data")
{:ok, raw_data} = File.read("input.txt")
Dec3.part_1(raw_data) |> IO.inspect(label: "part 1 real data")
Dec3.part_2(test_input) |> IO.inspect(label: "part 2 test data")
Dec3.part_2(raw_data) |> IO.inspect(label: "part 2 real data")

defmodule Dec3 do

  defp calc_priority_single_rucksack(rucksack) do
      rucksack 
      |> String.split_at(div(String.length(rucksack), 2))
      |> get_common_item
      |> calc_priority
  end

  # worst hack ever!? But hey I'm using a MapSet
  defp get_common_item( {compartment_a, compartment_b} ) do
      MapSet.intersection(MapSet.new(to_charlist(compartment_a)),
                    MapSet.new(to_charlist(compartment_b)))
      |> MapSet.to_list
      |> List.first
  end

  defp calc_priority(item) do
      if item > ?Z do
        item - (?a - 1)
      else
        item - (?A - 27)
      end
  end

  def part_1(rucksacks) do
    rucksacks
      |> String.split("\n", trim: true)
      |> Enum.map(& calc_priority_single_rucksack/1)
      |> Enum.sum
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
defmodule Dec3 do

  def calc_priority(rucksack) do
      {compartment_a, compartment_b} = 
      rucksack 
      |> String.split_at(div(String.length(rucksack), 2))
      # worst hack ever!? But hey I'm using a MapSet
      common_item = MapSet.intersection(MapSet.new(to_charlist(compartment_a)),
                    MapSet.new(to_charlist(compartment_b)))
      |> MapSet.to_list
      |> List.first

      if common_item > ?Z do
        common_item - (?a - 1)
        else
        common_item - (?A - 27)
      end
  end

  def part_1(rucksacks) do
    rucksacks
      |> String.split("\n", trim: true)
      |> Enum.map(& calc_priority/1)
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
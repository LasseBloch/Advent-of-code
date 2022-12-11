defmodule Dec4 do
  defp get_pairs_from_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&String.split(&1, ","))
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
  end

  def total_overloap?(pairs) do
    [elf_1, elf_2] = pairs

    # If we sort the egdes, if the value for an elf is at the extrems the other must be inccluded in that
    extremes = Enum.min_max(elf_1 ++ elf_2) |> Tuple.to_list()

    cond do
      elf_1 == extremes -> true
      elf_2 == extremes -> true
      true -> false
    end
  end

  def part_1(assignments) do
    assignments
    |> get_pairs_from_input
    |> Enum.count(&total_overloap?/1)
    |> IO.inspect()
  end
end

test_input = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

Dec4.part_1(test_input) |> IO.inspect(label: "part 1 test data")
{:ok, raw_data} = File.read("input.txt")
Dec4.part_1(raw_data) |> IO.inspect(label: "part 1 real data")

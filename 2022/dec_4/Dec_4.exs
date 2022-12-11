defmodule Dec4 do
  defp get_pairs_from_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&String.split(&1, ","))
    |> Enum.map(&String.split(&1, "-"))
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> Enum.chunk_every(2)
  end

  defp total_overloap?(pairs) do
    [elf_1, elf_2] = pairs

    # If we find the extremes of the elf lists combined,  and one of the elf list is equal to that
    # the otherlist must be included in that 
    extremes = Enum.min_max(elf_1 ++ elf_2) |> Tuple.to_list()

    cond do
      elf_1 == extremes -> true
      elf_2 == extremes -> true
      true -> false
    end
  end

  defp any_overloap?(pairs) do
    [elf_1, elf_2] = pairs
    {elf_1_s, elf_1_e} = elf_1 |> List.to_tuple()
    {elf_2_s, elf_2_e} = elf_2 |> List.to_tuple()

    cond do
      elf_1_s <= elf_2_s && elf_2_s <= elf_1_e -> true
      elf_2_s <= elf_1_s && elf_1_s <= elf_2_e -> true
      true -> false
    end
  end

  def part_1(assignments) do
    assignments
    |> get_pairs_from_input
    |> Enum.count(&total_overloap?/1)
  end

  def part_2(assignments) do
    assignments
    |> get_pairs_from_input
    |> Enum.count(&any_overloap?/1)
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
Dec4.part_2(test_input) |> IO.inspect(label: "part 2 test data")
Dec4.part_2(raw_data) |> IO.inspect(label: "part 2 real data")

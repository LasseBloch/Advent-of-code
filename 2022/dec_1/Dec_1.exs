defmodule Dec_1 do
  defp get_elf_snack_calories_list() do
    {:ok, raw_data} = File.read("input.txt")

    raw_data
    |> String.split(~r{\s}, trim: false)
    |> Enum.map(fn x -> if(x !== "", do: String.to_integer(x), else: 0) end)
    |> Enum.chunk_by(&(&1 == 0))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sort()
  end

  def top_elf_calc_count() do
    get_elf_snack_calories_list() |> List.last()
  end

  def top_3_total() do
    get_elf_snack_calories_list() |> Enum.take(-3) |> Enum.sum()
  end
end

Dec_1.top_elf_calc_count() |> IO.inspect(label: "Part 1")
Dec_1.top_3_total() |> IO.inspect(label: "Part 2")

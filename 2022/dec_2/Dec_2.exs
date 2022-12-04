defmodule Dec2 do
  @opponent_input_map %{"A" => :rock, "B" => :paper, "C" => :sissors}
  @protagonist_input_map %{"X" => :rock, "Y" => :paper, "Z" => :sissors}
  @input_move_map Map.merge(@opponent_input_map, @protagonist_input_map)
  @move_point %{rock: 1, paper: 2, sissors: 3}
  @result_point %{win: 6, draw: 3, lose: 0}

  defp score_round(round_move) do
    Map.fetch!(
      @move_point,
      round_move
      |> List.last()
    ) +
      Map.fetch!(@result_point, round_result(round_move))
  end

  defp map_to_moves(round_info) do
    round_info
    |> String.split()
    |> Enum.map(&Map.fetch!(@input_move_map, &1))
  end

  def parse_startegy_guide() do
    {:ok, raw_data} = File.read("input.txt")

    raw_data
    |> String.split("\n", trim: true)
    |> Enum.map(&map_to_moves/1)
    |> Enum.map(&score_round/1)
  end

  def round_result(round_moves) do
    {opponent_move, move} = List.to_tuple(round_moves)

    if move != opponent_move do
      case {move, opponent_move} do
        {:rock, :sissors} -> :win
        {:paper, :rock} -> :win
        {:sissors, :paper} -> :win
        _ -> :lose
      end
    else
      :draw
    end
  end
end

Dec2.parse_startegy_guide() |> Enum.sum() |> IO.inspect()

defmodule Dec2 do
  @opponent_input_map %{"A" => :rock, "B" => :paper, "C" => :sissors}
  @protagonist_input_map %{"X" => :rock, "Y" => :paper, "Z" => :sissors}
  @game_outcome_map %{"X" => :lose, "Y" => :draw, "Z" => :win}
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
    |> Enum.map(&Map.fetch!(@input_move_map, &1))
  end

  defp parse_startegy_guide() do
    {:ok, raw_data} = File.read("input.txt")

    raw_data
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
  end

  def part_1() do
    parse_startegy_guide()
    |> Enum.map(&map_to_moves/1)
    |> Enum.map(&score_round/1)
    |> Enum.sum()
  end

  def part_2() do
    parse_startegy_guide()
    |> Enum.map(&determine_play/1)
    |> Enum.map(&score_round/1)
    |> Enum.sum()
  end

  defp determine_play(round_moves) do
    {opponent_move, result} = List.to_tuple(round_moves)
    result = Map.fetch!(@game_outcome_map, result)
    opponent_move = Map.fetch!(@input_move_map, opponent_move)

    [
      opponent_move,
      case {opponent_move, result} do
        {_, :draw} -> opponent_move
        {:rock, :win} -> :paper
        {:rock, :lose} -> :sissors
        {:paper, :win} -> :sissors
        {:paper, :lose} -> :rock
        {:sissors, :lose} -> :paper
        {:sissors, :win} -> :rock
      end
    ]
  end

  defp round_result(round_moves) do
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

Dec2.part_1() |> IO.inspect(label: "part 1")
Dec2.part_2() |> IO.inspect(label: "part 2")

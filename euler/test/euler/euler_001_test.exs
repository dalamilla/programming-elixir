defmodule Euler.Euler001Test do
  use ExUnit.Case

  @parameters [
    {1000, 233_168},
    {49, 543},
    {8456, 16_687_353},
    {19564, 89_301_183}
  ]

  for {input, expec} <- @parameters do
    test "The sum of multiples of 3 or 5 below #{input}: #{expec}" do
      assert Euler.Euler001.solution(unquote(input)) == unquote(expec)
    end
  end
end

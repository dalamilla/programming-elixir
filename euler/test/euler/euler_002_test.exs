defmodule Euler.Euler002Test do
  use ExUnit.Case

  @parameters [
    {8, 10},
    {10, 10},
    {34, 44},
    {60, 44},
    {1000, 798},
    {100_000, 60696},
    {4_000_000, 4_613_732}
  ]

  for {input, expec} <- @parameters do
    test "The sum of even Fibonacci numbers below #{input}: #{expec}" do
      assert Euler.Euler002.solution(unquote(input)) == unquote(expec)
    end
  end
end

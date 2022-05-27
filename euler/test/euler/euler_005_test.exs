defmodule Euler.Euler005Test do
  use ExUnit.Case

  @parameters [
    {5, 60},
    {7, 420},
    {10, 2520},
    {13, 360_360},
    {20, 232_792_560}
  ]

  for {input, expec} <- @parameters do
    test "The smallest positive number that is evenly divisible by all of the numbers from 1 to  #{input}: #{expec}" do
      assert Euler.Euler005.solution(unquote(input)) == unquote(expec)
    end
  end
end

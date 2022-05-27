defmodule Euler.Euler004Test do
  use ExUnit.Case

  @parameters [
    {2, 9009},
    {3, 906_609}
  ]

  for {input, expec} <- @parameters do
    test "The largest palindrome made from the product of two #{input}-digit numbers: #{expec}" do
      assert Euler.Euler004.solution(unquote(input)) == unquote(expec)
    end
  end
end

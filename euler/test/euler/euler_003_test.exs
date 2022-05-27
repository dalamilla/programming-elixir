defmodule Euler.Euler003Test do
  use ExUnit.Case

  @parameters [
    {2, 2},
    {3, 3},
    {5, 5},
    {7, 7},
    {8, 2},
    {13195, 29},
    {600_851_475_143, 6857}
  ]

  for {input, expec} <- @parameters do
    test "The largest prime factor of #{input}: #{expec}" do
      assert Euler.Euler003.solution(unquote(input)) == unquote(expec)
    end
  end
end

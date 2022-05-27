defmodule Euler.Euler001 do
  @moduledoc """
  If we list all the natural numbers below 10 that are multiples of 3 or 5,
  we get 3, 5, 6 and 9. The sum of these multiples is 23.
  Find the sum of all the multiples of 3 or 5 below 1000.
  """

  @doc """
  Solution of first Euler problem.
  Computes the summatory of natural numbers that are multiples of 3 or 5 below n.
  """
  @spec solution(number) :: number
  def solution(n) do
    1..(n - 1)
    |> Enum.filter(fn x -> rem(x, 3) == 0 || rem(x, 5) == 0 end)
    |> Enum.sum()
  end
end

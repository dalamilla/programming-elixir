defmodule Euler.Euler003 do
  @moduledoc """
  The prime factors of 13195 are 5, 7, 13 and 29.
  What is the largest prime factor of the number 600851475143 ?
  """

  @doc """
  Solution of third Euler problem.
  Computes the largest prime factor of n.
  """
  @spec solution(number) :: number
  def solution(n) do
    Stream.unfold({n, 2}, fn {n, pm} ->
      if n != 1 do
        if rem(n, pm) == 0 do
          {pm, {div(n, pm), pm}}
        else
          {pm + 1, {n, pm + 1}}
        end
      end
    end)
    |> Enum.max()
  end
end

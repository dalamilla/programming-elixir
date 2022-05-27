defmodule Euler.Euler005 do
  @moduledoc """
  2520 is the smallest number that can be divided by each of  the numbers from
  1 to 10 without any remainder.
  What is the smallest positive number that is evenly divisible by all of the
  numbers from 1 to 20?
  """

  @doc """
  Solution of fifth Euler problem.
  Computes the smallest positive number that is evenly divisible by all of the numbers from 1 to n.
  """
  @spec solution(number) :: number
  def solution(n) do
    1..n
    |> Enum.reduce(1, fn a, b ->
      div(a * b, hcf(a, b))
    end)
  end

  # Helper function for fifth Euler problem.
  @spec hcf(number, number) :: number()
  defp hcf(0, b), do: b
  defp hcf(a, b), do: hcf(rem(b, a), a)
end

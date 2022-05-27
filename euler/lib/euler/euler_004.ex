defmodule Euler.Euler004 do
  @moduledoc """
  A palindromic number reads the same both ways. The largest palindrome made from
  the product of two 2-startDigit numbers is 9009 = 91 × 99.
  Find the largest palindrome made from the product of two 3-startDigit numbers.
  """

  @doc """
  Solution of fourth Euler problem.
  Computes the largest palindrome made from the product of two n-startDigit numbers.
  """
  @spec solution(number) :: number
  def solution(n) do
    list = Integer.pow(10, n - 1)..Integer.pow(10, n)

    List.flatten(for a <- list, b <- list, do: a * b)
    |> Enum.filter(fn x -> is_palindrome?(x) end)
    |> Enum.max()
  end

  # Helper function for fourth Euler problem.
  @spec is_palindrome?(number) :: boolean()
  defp is_palindrome?(n) do
    to_string(n) == to_string(n) |> String.reverse()
  end
end

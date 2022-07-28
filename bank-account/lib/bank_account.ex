defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @closed_error {:error, :account_closed}

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> {:open, 0} end)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """

  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, fn balance -> {:closed, balance} end)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    Agent.get(account, fn
      {:closed, _} -> @closed_error
      {:open, balance} -> balance
    end)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    Agent.get_and_update(account, fn
      {:closed, balance} -> {@closed_error, {:closed, balance}}
      {:open, balance} -> {:ok, {:open, balance + amount}}
    end)
  end
end

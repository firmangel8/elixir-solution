defmodule FreelancerRates do
  @monthly_billable_days_num 22 |> ceil
  @daily_rate_num 8.0

  def daily_rate(hourly_rate), do: hourly_rate * @daily_rate_num

  def apply_discount(before_discount, discount) do
    # Please implement the apply_discount/2 function
    before_discount * (100 - discount) / 100
  end

  defp daily_discounted_rate(hourly_rate, discount) do
    hourly_rate |> daily_rate |> apply_discount(discount)
  end

  def monthly_rate(hourly_rate, discount) do
    # Please implement the monthly_rate/2 function
    (daily_discounted_rate(hourly_rate, discount) * @monthly_billable_days_num) |> ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Please implement the days_in_budget/3 function
    (budget / daily_discounted_rate(hourly_rate, discount)) |> Float.floor(1)
  end
end

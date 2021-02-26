defmodule Rocketpay.Accounts.Deposit do
  alias Rocketpay.Accounts.Operation
  alias Rocketpay.Repo

  def call(params) do
    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      # na transaction ou roda tudo ou roda nada
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{deposit: account} = map} ->
        IO.inspect(map)
        {:ok, account}
    end
  end

end

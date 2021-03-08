defmodule Rocketpay do
  # estamos dizendo que Rocketpay.Users.Create tem um alias UserCreate
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.{Deposit, Withdraw, Transaction}

  # estamos delegando a função create_user(params) para o alias
  # UserCreate, que na verdade estará chamando a função call
  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate deposit(params), to: Deposit, as: :call
  defdelegate withdraw(params), to: Withdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end

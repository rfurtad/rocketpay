defmodule Rocketpay do
  # estamos dizendo que Rocketpay.Users.Create tem um alias UserCreate
  alias Rocketpay.Users.Create, as: UserCreate

  # estamos delegando a função create_user(params) para o alias
  # UserCreate, que na verdade estará chamando a função call
  defdelegate create_user(params), to: UserCreate, as: :call
end

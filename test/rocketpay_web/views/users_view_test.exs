defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase

  import Phoenix.View
  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
      user_params = %{
        name: "Roberto",
        age: 26,
        email: "saasaxz@saarsaea.com",
        nickname: "saksxa0a",
        password: "abchsa12548785"
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(user_params)

    response = render(RocketpayWeb.UsersView, "create.json", user: user)
    expected_response = %{message: "User created",
    user: %{account: %{
           balance: Decimal.new("0"),
           id: account_id},
           id: user_id,
           name: "Roberto", nickname: "saksxa0a"}}
    assert expected_response == response
  end
end

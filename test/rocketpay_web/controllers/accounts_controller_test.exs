defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase
  alias Rocketpay.{Account, User}
  describe "deposit/2" do
    setup %{conn: conn} do
      user_params = %{
        name: "Roberto",
        age: 26,
        email: "saasaxz@saarsaea.com",
        nickname: "saksxa0a",
        password: "abchsa12548785"
    }

    {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(user_params)

    conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")
    {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(201)

      assert %{
        "account" => %{
          "balance" => "50.00",
          "id" => _id},
          "message" => "Account updated"} = response
    end

    test "when params are invalid, don't make deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "-50.00"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expected_response =  %{"message" => %{"balance" => ["is invalid"]}}
      assert response == expected_response
    end
  end
end

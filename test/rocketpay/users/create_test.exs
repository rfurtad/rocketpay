defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase
  alias Rocketpay.User
  alias Rocketpay.Users.Create
  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
          name: "Roberto",
          age: 26,
          email: "saasaxz@saarsaea.com",
          nickname: "saksxa0a",
          password: "abchsa12548785"
      }
      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Roberto", age: 26, id: ^user_id} = user
    end

    test "when there ara invalid params, returns an user" do
      params = %{
          name: "Roberto",
          age: 6,
          email: "saasaxz@saarsaea.com",
          nickname: "saksxa0a",
          password: "abchsa12548785"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"]}
      assert errors_on(changeset) == expected_response
    end
  end
end

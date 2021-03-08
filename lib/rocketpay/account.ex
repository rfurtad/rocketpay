defmodule Rocketpay.Account do
  # aqui será criado o schema, ele mapeia o dado para a tabela
  # é como se fosse o model do Active Record
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Rocketpay.User
  # binary_id indica que é um UUID, esse comando abaixo
  # é como se fosse uma maneira de indicar como a sequence
  # do id seria gerada
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User
    timestamps()
  end

  # Diz pro banco quais dados serão colocados e roda as validações
  # ele mapeia e valida dados
  # %__MODULE__{} é uma struct vazia
  # cast pega os params e transforma e um changeset e os coloca em uma struct
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end

  # funcao change recebe um change set e retorna um novo modificado
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  # funcao change recebe um change set e retorna um novo modificado
  defp put_password_hash(changeset), do: changeset
end

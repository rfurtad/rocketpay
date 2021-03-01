defmodule Rocketpay.User do
  # aqui será criado o schema, ele mapeia o dado para a tabela
  # é como se fosse o model do Active Record
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  # binary_id indica que é um UUID, esse comando abaixo
  # é como se fosse uma maneira de indicar como a sequence
  # do id seria gerada
  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string
    timestamps()
  end

  # Diz pro banco quais dados serão colocados e roda as validações
  # ele mapeia e valida dados
  # %__MODULE__{} é uma struct vazia
  # cast pega os params e transforma e um changeset e os coloca em uma struct
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:nickname])
    |> put_password_hash()
  end

  # funcao change recebe um change set e retorna um novo modificado
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  # funcao change recebe um change set e retorna um novo modificado
  defp put_password_hash(changeset), do: changeset
end

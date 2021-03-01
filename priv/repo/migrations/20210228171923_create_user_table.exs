defmodule Rocketpay.Repo.Migrations.CreateUserTable do
  use Ecto.Migration
  # Para gerar esta tabela usamos o comando mix ecto.gen.migration create_user_table
  def change do
    create table :users do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :password_hash, :string
      add :nickname, :string
      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:nickname])
  end
end

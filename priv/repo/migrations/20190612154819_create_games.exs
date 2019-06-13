defmodule Challenge.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :description, :string
      add :image, :string
      add :promoted, :boolean, default: false
      add :tags, {:array, :string}

      timestamps()
    end
  end
end

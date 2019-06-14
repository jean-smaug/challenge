defmodule Challenge.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :mark, :integer
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:ratings, [:game_id])
  end
end

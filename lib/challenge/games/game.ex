defmodule Challenge.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :description, :string
    field :image, :string
    field :name, :string
    field :tags, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :description, :image, :tags])
    |> validate_required([:name, :description, :image])
  end
end

defmodule Challenge.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :description, :string
    field :image, :string, default: ""
    field :name, :string
    field :promoted, :boolean, default: false
    field :tags, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :description, :image, :tags, :promoted])
    |> validate_required([:name, :description, :image])
  end
end

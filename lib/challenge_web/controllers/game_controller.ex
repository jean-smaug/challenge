defmodule ChallengeWeb.GameController do
  use ChallengeWeb, :controller

  alias Challenge.{Games, Tags}
  alias Challenge.Games.Game
  alias Challenge.Utils

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.html", games: games)
  end

  def new(conn, _params) do
    changeset = Games.change_game(%Game{})
    tags = Tags.list_tags_tuples()

    render(conn, "new.html", changeset: changeset, tags: tags)
  end

  def create(conn, %{"game" => game_params}) do
    IO.inspect(game_params)

    if image = game_params["image"] do
      case Utils.File.move(image, "/public/images") do
        {:ok, file_name, _} ->
          game = Map.put(game_params, "image", file_name)

          case Games.create_game(game) do
            {:ok, game} ->
              conn
              |> put_flash(:info, "Game created successfully.")
              |> redirect(to: Routes.game_path(conn, :show, game))

            {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "new.html", changeset: changeset)
          end

        {:error, reason} ->
          IO.inspect(reason)
          nil
      end
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, "show.html", game: game)
  end

  def edit(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    changeset = Games.change_game(game)
    tags = Tags.list_tags_tuples()
    render(conn, "edit.html", game: game, changeset: changeset, tags: tags)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Games.get_game!(id)

    case Games.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: Routes.game_path(conn, :show, game))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    {:ok, _game} = Games.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: Routes.game_path(conn, :index))
  end
end

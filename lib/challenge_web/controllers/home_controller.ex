defmodule ChallengeWeb.HomeController do
  use ChallengeWeb, :controller

  alias Challenge.{Games}

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.html", games: games)
  end
end

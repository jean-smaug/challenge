defmodule ChallengeWeb.Router do
  use ChallengeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChallengeWeb do
    pipe_through :browser

    get "/", HomeController, :index
    resources "/games", GameController
    resources "/tags", TagController
    resources "/comments", CommentController
    resources "/ratings", RatingController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChallengeWeb do
  #   pipe_through :api
  # end
end

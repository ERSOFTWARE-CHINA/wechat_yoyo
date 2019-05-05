defmodule ApiServerWeb.Router do
  use ApiServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.Pipeline, module: ApiServerWeb.Guardian,
      error_handler: ApiServerWeb.AuthErrorHandler
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api/v1", ApiServerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    
    get "/plug_auth_failure/:msg", AuthFailureController, :plug_auth_failure
  end
end

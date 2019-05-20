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

  pipeline :wechat_auth do
    plug ApiServerWeb.Plugs.WechatAuth
  end

  scope "/api/v1", ApiServerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/post_comments", PostCommentController, except: [:new, :edit]
    resources "/commodities", CommodityController, except: [:new, :edit]
    resources "/services", ServiceController, except: [:new, :edit]
    resources "/orders", OrderController, except: [:new, :edit]
    resources "/service_orders", ServiceOrderController, except: [:new, :edit]
    resources "/technicians", TechnicianController, except: [:new, :edit]
    resources "/appointments", AppointmentController, except: [:new, :edit]


    get "/username/check", UserController, :check_username
    get "/wechat", WechatController, :get_userinfo
    get "/plug_auth_failure/:msg", AuthFailureController, :plug_auth_failure
  end

  scope "/app-api/v1", ApiServerWeb do
    pipe_through :wechat_auth

    resources "/users", UserController, except: [:new, :edit]
    resources "/posts", PostController, except: [:new, :edit]
    resources "/post_comments", PostCommentController, except: [:new, :edit]
    resources "/commodities", CommodityController, except: [:new, :edit]
    resources "/services", ServiceController, except: [:new, :edit]
    resources "/orders", OrderController, except: [:new, :edit]
    resources "/service_orders", ServiceOrderController, except: [:new, :edit]
    resources "/technicians", TechnicianController, except: [:new, :edit]
    resources "/appointments", AppointmentController, except: [:new, :edit]
  end
end

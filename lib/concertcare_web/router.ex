defmodule ConcertcareWeb.Router do
  use ConcertcareWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

	pipeline :auth do
	  plug ConcertcareWeb.Auth.GuardianPipeline
	end

	# We use ensure_auth to fail if there is no one logged in
	pipeline :ensure_auth do
	  plug Guardian.Plug.EnsureAuthenticated
	end

  scope "/api", ConcertcareWeb do
    pipe_through :api

    post "/users/signup",   UserController, :create
    post "/users/login",    UserController, :login
    delete "/users/logout", UserController, :logout

  end

  scope "/api", ConcertcareWeb do
    pipe_through [:api, :auth, :ensure_auth]

    post 	"post", 		PostController, :create
    post 	"post/:id", 	PostController, :show
    put 	"post/:id", 	PostController, :update
    delete 	"post/:id", 	PostController, :delete

    #read all post which belong to a particular user
    post 	"posts/:id", 	PostController, :show_all

  end

end

defmodule PreventWeb.Router do
  use PreventWeb, :router

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

  scope "/", PreventWeb do
    pipe_through :browser

    get "/", MainController, :index

    post "/login", MainController, :login
    get "/home", MainController, :home
    get "/doctor", MainController, :home_doctor
    get "/hospital", MainController, :home_hospital
    get "/calendar/doctor", MainController, :home_calendar_doctor

    get "/clinic", ClinicController, :index
    get "/clinic/detail", ClinicController, :detail
    get "/clinic/new", ClinicController, :new
    #Save clinic adult
    post "/clinic/adult/new", ClinicController, :new_adult

    get "/calendar", CalendarController, :index
    get "/calendar/hospital", CalendarController, :hospital_list
    get "/calendar/doctor/availability", CalendarController, :doctor_availability
    post "/calendar/doctor/availability", CalendarController, :save_doctor_availability
    get "/hospital/new", CalendarController, :new_hospital
    get "/hospital/update", CalendarController, :update_hospital
    post "/hospital/save", CalendarController, :save_hospital



    get "/patient/new", ProfileController, :new_patient
    post "/patient/save", ProfileController, :save_patient

    get "/doctor/new", ProfileController, :new_doctor
    get "/doctor/update", ProfileController, :update_doctor
    post "/doctor/save", ProfileController, :save_doctor

  end

  # Other scopes may use custom stacks.
  # scope "/api", PreventWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PreventWeb.Telemetry
    end
  end
end

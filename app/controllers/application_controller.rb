class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    unless session[:admin]
      redirect_to(login_path, :notice => "Must be logged in.")
      false
    end
  end
end

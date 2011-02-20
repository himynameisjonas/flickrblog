class AdminController < ApplicationController
  before_filter :authorize, :except => [:login]
  
  def login
    if request.post?
      if params[:password] == Setting.password && params[:username] == Setting.username
        session[:admin] = true
        redirect_to admin_path
      else
        flash[:notice] = "wrong username/password"
      end
    end
  end
  
  def logout
    session[:admin] = nil
    redirect_to root_path
  end
  
  def index
    @setting = Setting
  end
  
  def update
    params[:setting].each do |key,value|
      Setting.send("#{key}=", value)
    end
    redirect_to admin_path, :notice => "Settings saved"
  end
end

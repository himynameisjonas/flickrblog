class AdminController < ApplicationController
  before_filter :authorize, :except => [:login,:omniauth]
  
  def omniauth
    omniauth = request.env["omniauth.auth"]
    if Setting.user_id.nil?
      Setting.flickr_user_id = omniauth["uid"]
      Setting.flickr_token = omniauth["credentials"]["token"]
      session[:admin] = true
      redirect_to admin_path
    elsif Setting.flickr_user_id != omniauth["uid"]
      redirect_to(login_path, :notice => "eh, you are not the chosen one")
    else
      session[:admin] = true
      redirect_to admin_path, :notice => "welcome back!"
    end
  end
  
  def photosets
    @photosets = Rails.cache.fetch("photosets", :expires_in => 5.minutes) do
      doc = Nokogiri::XML(open("http://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=#{Setting.flickr_api_key}&user_id=#{Setting.flickr_user_id}"))
      doc.css("photoset").map do |photoset|
        {
          :id => photoset.attr(:id),
          :name => photoset.at_css("title").text
        }
      end
    end
  end
  
  def login
    redirect_to "/auth/flickr"
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
    Photo.clear_cache
    redirect_to admin_path, :notice => "Settings saved"
  end
end

class BlogController < ApplicationController
  def index
    @photos = Photo.all
  end
  
  def show
    @photo = Photo.find(params[:id])
    render(:file => "public/404.html", :status => 404, :layout => false) unless @photo
    render :layout => false if request.xhr?
  end
  
  def latest
    @photo = Photo.all.last
    render :action => :show
  end
  
end

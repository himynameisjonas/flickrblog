class BlogController < ApplicationController
  def index
    @photos = Photo.all
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def latest
    @photo = Photo.all.last
    render :action => :show
  end
  
end

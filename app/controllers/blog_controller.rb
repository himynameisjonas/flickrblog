class BlogController < ApplicationController
  def index
    @photos = Photo.all
  end

end

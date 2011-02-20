class Photo
  attr_accessor :id, :thumbnail_url, :large_url, :medium_url, :index, :orientation, :title, :taken_at
  require 'open-uri'
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def self.all
    Rails.cache.fetch("all_photos", :expires_in => 5.minutes) do
      doc = Nokogiri::XML(open("http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=#{Setting.flickr_api_key}&photoset_id=#{Setting.flickr_photoset_id}&extras=url_sq%2Curl_m%2Curl_l%2Curl_o,date_taken"))
      photos = Array.new
      doc.css("photo").to_a.each_index do |index|
        photo = doc.css("photo")[index]
        photos[index] = self.new(
          :id => photo.attr("id"),
          :thumbnail_url => photo.attr("url_sq"),
          :large_url => photo.attr("url_l"),
          :medium_url => photo.attr("url_m"),
          :index => index,
          :title => photo.attr("title"),
          :taken_at => DateTime.parse(photo.attr("datetaken")),
          :orientation => (photo.attr("height_m") > photo.attr("width_m") ? :portrait : :landscape)
        )
      end
      photos
    end
  end
  
  def self.find(id)
    self.all.select{|photo| photo.id == id}.first
  end
  
  def next
    self.class.all.fetch(self.index + 1, nil)
  end
  
  def previous
    self.class.all[self.index - 1] unless self.index-1 < 0
  end
  
  def to_param
    self.id
  end
  
end
class Photo
  attr_accessor :id, :thumbnail_url, :large_url, :index
  require 'open-uri'
  @@allphotos = nil
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def self.all
    return @@allphotos if @@allphotos
    doc = Nokogiri::XML(open("http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=c794c3f00be2130085e3cdef2f06aeb6&photoset_id=72157625847846478&extras=url_sq%2Curl_m%2Curl_l%2Curl_o"))
    photos = Array.new
    doc.css("photo").to_a.each_index do |index|
      photo = doc.css("photo")[index]
      photos[index] = self.new(
        :id => photo.attr("id"),
        :thumbnail_url => photo.attr("url_sq"),
        :large_url => photo.attr("url_l"),
        :index => index
      )
    end
    @@allphotos = photos
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
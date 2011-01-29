class Photo
  attr_accessor :id, :url_thumbnail
  require 'open-uri'
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def self.all
    doc = Nokogiri::XML(open("http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=c794c3f00be2130085e3cdef2f06aeb6&photoset_id=72157625847846478&extras=url_sq%2Curl_m%2Curl_l%2Curl_o"))
    doc.css("photo").map do |photo|
      self.new(
        :id => photo.attr("id"),
        :url_thumbnail => photo.attr("url_sq")
      )
    end
  end
end
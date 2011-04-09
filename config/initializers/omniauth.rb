Rails.application.config.middleware.use OmniAuth::Builder do
  provider :flickr, 'c794c3f00be2130085e3cdef2f06aeb6', '12661a297b1dfd88', :scope => 'read'
end
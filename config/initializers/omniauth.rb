Rails.application.config.middleware.use OmniAuth::Builder do
  provider :flickr, CONFIG['flickr_api_key'], CONFIG['flickr_api_secret'], :scope => 'read'
end
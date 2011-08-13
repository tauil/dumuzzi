require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'kkUO0CNioUNKP1urWcqLw', 'SGlyCahJBb4ellJWi7T5bEtGtj0AYMSVHS1oFrGyes'
end

require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6Q4EkvJyO498JBsmz6w', 'eD8Hq3MsW44i11corhqQhvmMYKITi1mR4t8TtuGU'
end

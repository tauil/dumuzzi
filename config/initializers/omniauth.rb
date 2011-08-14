require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '6Q4EkvJyO498JBsmz6w', 'eD8Hq3MsW44i11corhqQhvmMYKITi1mR4t8TtuGU'
  #provider :facebook, "132542963506807", "9b05e74ce3574493aca873cbe9c93d9c"
end

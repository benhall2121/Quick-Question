require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ghWeXRr6E82mo9tRuPU9A', 'FEcThgUFHhrKiPRIAoy6a2khF4fyN8S9odTfFmMg'
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end

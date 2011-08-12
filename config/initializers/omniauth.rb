require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ghWeXRr6E82mo9tRuPU9A', 'FEcThgUFHhrKiPRIAoy6a2khF4fyN8S9odTfFmMg'
  provider :facebook, "131985646895644", "91c62cfef0a20bfaa04418310aade017", {:scope => 'publish_stream,offline_access,email'}
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '221737857912452', '329198e3c954437020325c9697aa9510', :scope => 'email,offline_access'
end
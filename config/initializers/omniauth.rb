Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           scope: 'public_profile,email',
           info_fields: 'id,email,name'

  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'],
           image_aspect_ratio: 'square', image_size: 48, access_type: 'online',
           name: 'google'

  provider :discord, ENV['DISCORD_KEY'], ENV['DISCORD_SECRET']
end

OmniAuth.config.on_failure = proc do |env|
  SessionsController.action(:auth_failure).call(env)
end

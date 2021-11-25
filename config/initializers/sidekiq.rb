require 'sidekiq'
require 'sidekiq/web'

#url =

Sidekiq.configure_server do |config|
	config.redis =  {url: ENV.fetch("REDISCLOUD_URL")}
end

#Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
#	[user, password] == ["grenias", "grenias"]
#	end


Sidekiq.configure_client do |config|
	#config.redis =  {url: ENV.fetch("REDISCLOUD_URL")}
	#config.redis = { url: "redis://#{Redis.current.connection[:location]}" }
	config.redis = { url: ENV.fetch("REDISCLOUD_URL") }
end


#Sidekiq::Web.app_url = '/">Regresar</a><a style="display:none'
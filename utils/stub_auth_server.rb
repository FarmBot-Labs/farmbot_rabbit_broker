require "sinatra"
require "pry"

set port: 2222
set bind: '0.0.0.0'

post '/user' do
  # user = params["username"]
  # pass = params["password"]
  puts params.to_s
  "allow"
end


post '/vhost' do
  # user = params["username"]
  # host = params["vhost"]
  # ip   = params["ip"]
  puts params.to_s
  "allow"
end

post '/resource' do
  # user       = params["username"]
  # host       = params["vhost"]
  # resource   = params["resource"]
  # name       = params["name"]
  # permission = params["permission"]
  puts params.to_s
  "allow"
end


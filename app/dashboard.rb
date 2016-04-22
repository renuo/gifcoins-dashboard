require 'sinatra'

require 'sinatra/base'

class Dashboard < Sinatra::Base
  get '/dashboard' do
    'Hello World'
  end
end
require 'sinatra/base'
require 'coffee-script'

class Base < Sinatra::Base
  set :protection, except: [:frame_options]
end

class SassHandler < Base
  set :views, File.dirname(__FILE__) + '/assets/css'
  get '/css/dashboard.css' do
    sass :dashboard
  end

end

class CoffeeHandler < Base
  set :views, File.dirname(__FILE__) + '/assets/js'
  get "/js/application.js" do
    coffee :application
  end
end

class Dashboard < Base
  use SassHandler
  use CoffeeHandler

  set :views, File.dirname(__FILE__) + '/views'

  get '/' do
    slim :dashboard
  end
end
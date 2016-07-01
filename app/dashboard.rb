require 'sinatra/base'
require 'coffee-script'

class SassHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/assets/css'
  get '/css/dashboard.css' do
    sass :dashboard
  end

end

class CoffeeHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/assets/js'
  get "/js/application.js" do
    coffee :application
  end
end

class Dashboard < Sinatra::Base
  use SassHandler
  use CoffeeHandler

  set :views, File.dirname(__FILE__) + '/views'

  get '/' do
    slim :dashboard
  end
end
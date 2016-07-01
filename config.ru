$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'app/dashboard'
require 'figaro'

ENV.update YAML.load_file('config/application.yml') rescue {}

run Dashboard
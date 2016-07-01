require 'figaro'

class DataProvider
  def json_data
    Figaro.env.json_data
  end
end
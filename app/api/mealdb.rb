require 'net/http'
require 'json'
require 'httparty'
class Mealdb
  BASE_URL = "https://www.themealdb.com/api/json/v1/1/"
  SEARCH_MEAL = "#{BASE_URL}list.php?c=list"
  MEAL_BYLETTER = "https://www.themealdb.com/api/json/v1/1/search.php?f=b"

  def search_mealbyName(meal_name)
    meal_name = meal_name&.gsub(' ', '%20')
    response = HTTParty.get("http://www.themealdb.com/api/json/v1/1/search.php?s=#{meal_name}")
  end
  def mealbyletter
    response = HTTParty.get(MEAL_BYLETTER)
  end
end

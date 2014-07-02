class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @added_meal_today = current_user.check_for_meal_today
    @meals = current_user.get_meals_since_sunday
    @todays_meal = @meals.shift
    binding.pry
    @company_meals = current_user.company.meals_since_sunday_sorted
  end

end

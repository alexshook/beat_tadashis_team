class CompaniesController < ApplicationController
include CompaniesHelper
	def index
		@user = current_user
		if !@user.admin
			redirect_to root_path
		else
			@company_meals = Meal.where(company: @user.company).order(rating: :desc)
			@best_meals = @company_meals.take(20)
			@worst_meals = @company_meals.reverse.take(5)
		end
	end


end

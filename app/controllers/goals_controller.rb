class GoalsController < ApplicationController

  def create
    goal = Goal.new goal_params
    if goal.save
      redirect_to companies_path
    else
      render 'new'
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:name, :desc, :company_id)
  end

end

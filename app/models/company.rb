class Company < ActiveRecord::Base
  has_many :users
  has_many :meals
  has_many :goals

  def meals_since_sunday
    last_sunday_night = Date.today.beginning_of_week(:monday).to_datetime.change(hour: 1)
    self.meals.select { |m| m.created_at > last_sunday_night }
  end

  def meals_since_sunday_sorted
    last_sunday_night = Date.today.beginning_of_week(:monday).to_datetime.change(hour: 1)
    meals = self.meals.order(rating: :desc)
    meals.select { |m| m.created_at > last_sunday_night }
  end

end



module CompaniesHelper
  def date_uploaded(meal)
    meal.created_at.strftime("%b %e, %Y")
  end

end

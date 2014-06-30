class Meal < ActiveRecord::Base
  has_many :ratings
  belongs_to :goal
  belongs_to :user
	belongs_to :company

  has_attached_file :meal_photo,
                    :styles => {  :medium => "700x700#",
                                  :thumb => "100x100#" },
                                  :default_url => "https://http://s3.amazonaws.com/beattadashi/users/profile_photos/000/000/005"
  validates_attachment_content_type :meal_photo, :content_type => /\Aimage\/.*\Z/
  validates(:meal_photo, presence: true)

  def self.check_nutritional_facts(ingredients_string)
    ingredients_array = []
    # If there are commas in input, split into array, else make array of string
    if ingredients_string.include?(", ")
      ingredients_array = ingredients_string.downcase.split(", ")
    else
      ingredients_array.push(ingredients_string.downcase)
    end

    # check each element in array and split on with and remove and
    ingredients_array.each do |string|
      if string.include? "with "
        string.split("with ")
      end
      if string.include? "and "
        string.slice!("and ")
      end
    end

    # flatten array
    ingredients_array.flatten!
    ingredients_array.each do |string|
      string.gsub!(" ", "+")
    end

    return Sensum.nutrition_lookup(ingredients_array)
  end

end


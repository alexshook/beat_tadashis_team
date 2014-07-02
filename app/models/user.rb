class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  has_many :ratings
  has_many :meals

  has_attached_file :profile_photo,
                    :styles => {  :medium => "300x300#",
                                  :thumb => "100x100#" },
                                  :default_url => "https://s3.amazonaws.com/beattadashi/users/profile_photos/000/000/005/medium/placeholder.jpg"
  validates_attachment_content_type :profile_photo, :content_type => /\Aimage\/.*\Z/

  def check_for_meal_today
    todays_date = Time.now.utc.to_s.gsub(/\s.*/, '')
    # todays_date = Time.now.end_of_day.utc.to_s.gsub(/\s.*/, '')
    self.meals.last.created_at.to_s.include?(todays_date.gsub(/\s.*/, '')) ? true : false
  end

  def get_meals_since_sunday
    last_sunday_night = Date.today.beginning_of_week(:monday).to_datetime.change(hour: 1)
    meals = self.meals.order(created_at: :desc)
    meals.select { |m| m.created_at > last_sunday_night }
  end

end

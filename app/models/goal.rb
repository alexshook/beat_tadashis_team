class Goal < ActiveRecord::Base
  has_many :meals
  belongs_to :company
  validates :name, presence: true
end

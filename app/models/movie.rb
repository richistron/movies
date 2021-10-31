class Movie < ApplicationRecord
  belongs_to :director
  validates_presence_of :title, :description
  has_many :casts
  has_many :actors, through: :casts
end

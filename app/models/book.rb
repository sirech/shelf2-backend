class Book < ApplicationRecord
  validates :title, presence: true, length: { in: 5..200 }
  validates :description, length: { maximum: 500 }
  validates :year, numericality: { greater_than_or_equal_to: 2000 }
  validates :stars, inclusion: { in: 1..5 }

  enum :category, { sociology: 0, software: 1, econ: 2, history: 3, other: 4 }
end

class TechnologyTag < ApplicationRecord
  validates :name, length: {minimum: 1}, presence: true
end

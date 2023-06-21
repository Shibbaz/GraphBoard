class Video < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :type, presence: true
end

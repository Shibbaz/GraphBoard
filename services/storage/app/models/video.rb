class Video < ApplicationRecord
  validates :name, presence: true
  validates :author, presence: true
  validates :rules, presence: true
  validates :id, presence: true
  validates :description, presence: true
  validates :type, presence: true
end

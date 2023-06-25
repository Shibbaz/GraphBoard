class Offer < ApplicationRecord
    validates :name, presence: true, length: { minimum: 8 }
    validates :description, presence: true, length: { minimum: 15 }
    validates :requirements, presence: true, length: {
        minimum: 1, message: 'should have at least 1 requirement defined.'
    }
    validates :tags, presence: true
    validates :author, presence: true
    validates :contact_details, presence: true, length: {
        minimum: 1, message: 'should have at least contact details.'
    }
end

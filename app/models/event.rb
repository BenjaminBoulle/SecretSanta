class Event < ApplicationRecord
  belongs_to :user
  has_many :participants

  validates :max_amount, numericality: { only_integer: true }
end

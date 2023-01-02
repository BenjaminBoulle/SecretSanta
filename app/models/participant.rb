class Participant < ApplicationRecord
  belongs_to :event

  validates :email, uniqueness: true, presence: true
  validates :email, format: { with: /\A.*@.*\.com\z/ }
end

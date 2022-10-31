class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions
  validates_presence_of :email, :address
end
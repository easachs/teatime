# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions
  validates_presence_of :first_name, :last_name, :address
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end

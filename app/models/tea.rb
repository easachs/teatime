# frozen_string_literal: true

class Tea < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions
  validates_presence_of :title, :description
end

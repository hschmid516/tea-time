class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  validates :first_name, :last_name, :email, :address, presence: true
end

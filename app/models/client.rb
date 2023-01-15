class Client < ApplicationRecord
  has_many :reports
  has_many :users, through: :reports
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :phone, presence: true, length: { maximum: 20}
end

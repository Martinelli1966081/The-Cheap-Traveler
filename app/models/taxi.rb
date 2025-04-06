class Taxi < ApplicationRecord
  before_validation :generate_code, on: :create
  belongs_to :user
  has_one :reservation, foreign_key: :code_taxi, primary_key: :code, dependent: :destroy
  
  validates :partenza, :arrivo, :day, :code, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :code, uniqueness: true
  
  private
  
  def generate_code
    self.code ||= SecureRandom.random_number(10000..99999)
  end
end
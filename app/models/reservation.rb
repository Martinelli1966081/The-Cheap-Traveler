class Reservation < ApplicationRecord
  validates :check_in, :check_out, presence: true
end
# spec/controllers/reservations_controller_spec.rb
require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:user) do
    User.new(email: "test@example.com", password: "Password2000-", username: "testuser").tap do |u|
      u.skip_confirmation!
      u.save!
    end
  end

  let(:stay) { Stay.create!(name: "Hotel Paradiso", city: "Roma", country: "Italia", price: 100.0) }

  before { sign_in user }

  describe "POST create" do
    it "creates a reservation and redirects to index" do
      post :create, params: {
        reservation: {
          name_stay: stay.name,
          check_in: Date.today + 1,
          check_out: Date.today + 4,
          people: 2,
          user: user.id
        }
      }

      reservation = Reservation.last
      expect(reservation.name_stay).to eq("Hotel Paradiso")
      expect(reservation.people).to eq(2)
      expect(response).to redirect_to(reservations_path)
    end
  end
end

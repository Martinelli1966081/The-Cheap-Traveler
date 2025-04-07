require 'rails_helper'

RSpec.feature "UserBooksAStay", type: :feature do
  let!(:user) do
    User.new(email: "test@example.com", password: "Password2000-", username: "testuser").tap do |u|
      u.skip_confirmation!
      u.save!
    end
  end
  let!(:stay) { Stay.create!(name: "Hotel Paradiso", city: "Roma", country: "Italia", price: 100.0) }

  scenario "User books a stay successfully" do
    login_as(user, scope: :user)

    visit stays_path
    click_link "Hotel Paradiso"

    fill_in "Check-in", with: Date.today + 1
    fill_in "Check-out", with: Date.today + 4
    fill_in "Persone", with: 2
    click_button "Prenota"

    expect(page).to have_content("Prenotazione confermata")
    expect(page).to have_current_path(reservations_path)
    expect(page).to have_content("Hotel Paradiso")
    expect(page).to have_content((Date.today + 1).to_s)
    expect(page).to have_content((Date.today + 4).to_s)
    expect(page).to have_content("2 persone")
  end
end

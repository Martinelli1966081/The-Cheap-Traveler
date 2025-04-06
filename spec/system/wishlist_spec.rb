# spec/system/adding_stay_to_wishlist_spec.rb
require 'rails_helper'

RSpec.describe "Adding Stay to Wishlist", type: :system do
  let(:user) do
    User.new(username: "sofia", email: "sofia@email.com", password: "Password2000-").tap do |u|
      u.skip_confirmation!
      u.save!
    end
  end
  let(:stay) { Stay.create!(name: "Villa delle Rose", price: 100) }

  before do
    driven_by(:rack_test) 
    # Simula il login dell'utente
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "Password2000-"
    click_button "Accedi"
  end

  it "allows user to add stay to wishlist" do
    # Visita la pagina degli stays
    visit stays_path

    # Assicurati che la struttura appaia nella lista
    expect(page).to have_content("Villa delle Rose")

    # Clicca sul bottone per aggiungere alla wishlist
    click_button "Aggiungi alla wishlist"

    # Verifica che il sistema reindirizza alla pagina della wishlist
    expect(page).to have_current_path(wishlist_path)

    # Verifica che la struttura sia stata aggiunta alla wishlist dell'utente
    expect(page).to have_content("Villa delle Rose")
  end
end

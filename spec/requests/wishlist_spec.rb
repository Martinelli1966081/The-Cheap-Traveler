# spec/requests/wishlist_spec.rb
require 'rails_helper'

RSpec.describe "Wishlists", type: :request do
  let(:user) do
    User.new(username: "sofia", email: "sofia@email.com", password: "Password2000-").tap do |u|
      u.skip_confirmation!
      u.save!
    end
  end
  let(:stay) { Stay.create!(name: "Villa delle Rose", price: 100) }

  before do
    # Simula il login dell'utente
    post login_path, params: { email: user.email, password: "Password2000-" }
  end

  it "adds a stay to the user's wishlist" do
    # Verifica che inizialmente la wishlist sia vuota
    expect(Wishlist.count).to eq(0)

    # Fai la richiesta per aggiungere la stay alla wishlist
    post wishlists_path, params: { stay_id: stay.id }

    # Verifica che una nuova entry sia stata aggiunta alla wishlist
    expect(Wishlist.count).to eq(1)
    expect(Wishlist.last.user).to eq(user)
    expect(Wishlist.last.stay).to eq(stay)

    # Verifica che l'utente venga reindirizzato alla pagina wishlist
    follow_redirect!
    expect(response).to render_template('wishlists/show')
  end
end

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
    post login_path, params: { email: user.email, password: "Password2000-" }
  end

  it "adds a stay to the user's wishlist" do
    expect(Wishlist.count).to eq(0)

    post wishlists_path, params: { stay_id: stay.id }


    expect(Wishlist.count).to eq(1)
    expect(Wishlist.last.user).to eq(user)
    expect(Wishlist.last.stay).to eq(stay)


    follow_redirect!
    expect(response).to render_template('wishlists/show')
  end
end

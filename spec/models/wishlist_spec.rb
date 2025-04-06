require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  let(:user) do
    User.new(username: "sofia", email: "sofia@email.com", password: "Password2000-").tap do |u|
      u.skip_confirmation!
      u.save!
    end
  end
  let(:stay) { Stay.create!(name: "Villa delle Rose", price: 100) }

  it "is valid with a user and a stay" do
    wishlist = Wishlist.new(user: user, stay: stay)
    expect(wishlist).to be_valid
  end

  it "is invalid without a user" do
    wishlist = Wishlist.new(user: nil, stay: stay)
    expect(wishlist).to_not be_valid
  end

  it "is invalid without a stay" do
    wishlist = Wishlist.new(user: user, stay: nil)
    expect(wishlist).to_not be_valid
  end
end
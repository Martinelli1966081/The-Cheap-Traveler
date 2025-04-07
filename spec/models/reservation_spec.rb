require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject {
    described_class.new(
      name_stay: "Hotel Paradiso",
      check_in: Date.today + 1,
      check_out: Date.today + 4,
      people: 2,
      user: 1
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without a check_in date" do
    subject.check_in = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without a check_out date" do
    subject.check_out = nil
    expect(subject).not_to be_valid
  end

  it "is invalid if people is not present" do
    subject.people = nil
    expect(subject).not_to be_valid
  end

  it "calculates days_counter correctly" do
    subject.days_counter = (subject.check_out - subject.check_in).to_i
    expect(subject.days_counter).to eq(3)
  end
end

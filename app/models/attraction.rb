class Attraction < ApplicationRecord
    has_one_attached :image

    scope :most_viewed, -> { order(views_count: :desc) }
end

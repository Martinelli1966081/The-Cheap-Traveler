class Stay < ApplicationRecord
    has_one_attached :image
    belongs_to :user, optional: true
    has_many :wishlists

  
    # Validazione solo per business users
    validate :user_business_if_present
  
    scope :with_owner, -> { where.not(user_id: nil) }
    scope :without_owner, -> { where(user_id: nil) }
    scope :owned_by, ->(user) { where(user_id: user.id) }

    scope :most_viewed, -> { order(views_count: :desc) }
  
    private
  
    def user_business_if_present
      if user_id.present? && !user.business?
        errors.add(:user_id, "must be a business account")
      end
    end
end

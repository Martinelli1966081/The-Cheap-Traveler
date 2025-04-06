class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :email, 
      uniqueness: { case_sensitive: false },
      format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :username, 
      presence: true,
      uniqueness: { case_sensitive: false }
      
  validate :strong_password
  validates :phone_number, 
  format: { with: /\A\+?\d{10,15}\z/, message: "deve essere un numero valido" }, 
  allow_blank: true
  has_many :taxis, dependent: :destroy
  has_many :stays, foreign_key: 'user_id', inverse_of: :user, dependent: :nullify

  #Carta di credito
  KEY = [ENV['CARD_ENCRYPTION_KEY']].pack('H*')

  attr_encrypted :card_number, key: KEY
  attr_encrypted :card_expiry, key: KEY
  attr_encrypted :card_cvc,    key: KEY

  validates :card_number, format: { with: /\A(\d{4}(\s)?){3,4}\z/}, allow_blank: true
  validates :card_expiry, format: { with: /\A(0[1-9]|1[0-2])\/?\d{2}\z/ }, allow_blank: true
  validates :card_cvc,    format: { with: /\A\d{3,4}\z/ }, allow_blank: true

  def send_confirmation_instructions
    generate_confirmation_token! unless @raw_confirmation_token
    send_devise_notification(:confirmation_instructions, @raw_confirmation_token, {})
  end

  def generate_upgrade_token!
    self.upgrade_token = SecureRandom.urlsafe_base64
    self.upgrade_token_sent_at = Time.now
    save!
  end

  def upgrade_token_valid?
    upgrade_token_sent_at > 24.hours.ago
  end

  def owned_stays
    business? ? stays : Stay.none
  end

  def username
    read_attribute(:username) || email.split('@').first
  end

  def self.from_omniauth(auth)
    begin
      user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
      if user.new_record?
        user.email = auth.info.email
        user.password = generate_strong_password # <-- Modifica qui
        user.password_confirmation = user.password
        user.username = auth.info.name || generate_unique_username(auth.info)
        user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
      end
      user.save
      user
    rescue => e
      Rails.logger.error "OAuth Error: #{e.message}"
      User.new(provider: auth.provider, uid: auth.uid).tap do |u|
        u.errors.add(:base, "OAuth processing failed")
      end
    end
  end

  private 
  def self.generate_strong_password
    special_chars = ['!', '@', '#', '$', '%', '^', '&', '*'].freeze
    [
      ('A'..'Z').to_a.sample,           
      ('a'..'z').to_a.sample,          
      rand(10).to_s,                    
      special_chars.sample,             
      Devise.friendly_token(7)          
    ].shuffle.join.ljust(11, rand(10).to_s)[0..10] 
  end

  def self.generate_unique_username(auth_info)
    base = auth_info.name || auth_info.email.split('@').first
    base = base.downcase.gsub(/[^a-z0-9]/, '_')[0..14]
    loop do
      username = "#{base}_#{rand(100..999)}"
      break username unless User.exists?(username: username)
    end
  end

  def strong_password
    return if password.blank?

    unless password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).{11,}\z/)
      errors.add(:password, "deve contenere una maiuscola, una minuscola, un numero e un carattere speciale")
    end
  end

  def set_default_business
    self.business = false if business.nil?
  end

end
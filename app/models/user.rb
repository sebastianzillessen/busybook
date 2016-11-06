require 'digest/sha2'

class User < ActiveRecord::Base

  validates :name, uniqueness: true
  has_many :calendars, dependent: :destroy
  has_many :schedules, through: :calendars
  has_many :offers

  def validate_password(password)
    self.password_hash == hash(password + self.password_salt)
  end

  def password=(password)
    salt = SecureRandom.base64(16)
    self.password_salt = salt
    self.password_hash = hash(password + salt)
  end


  def get_offer_calendar
    self.calendars.find_by_name("Proposed") || self.calendars.first
  end

  def get_non_offer_calendar
    self.calendars.find_by_name("Proposed") || self.calendars.first
  end

  private

  def hash(x)
    Digest::SHA2.hexdigest(x)
  end
end

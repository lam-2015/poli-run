# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  # this method realizes the authentication system, basically
  has_secure_password

  # put the email in downcase before saving the user
  before_save { |user| user.email = email.downcase }

  # call the create_remember_token private method before saving the user
  before_save :create_remember_token

  # name must be always present and with a maximum length of 50 chars
  validates :name, presence: true, length: { maximum: 50 }

  # email allowed format representation (expressed as a regex)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)*polito.it\z/i

  # email must be always present, unique and with a specific format
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # password must have a minimum length of 8 chars
  # password and password_confirmation presence is enforced by has_secure_password
  validates :password, length: { minimum: 8 }


  # private methods
  private

  def create_remember_token
    # create a random string, safe for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end

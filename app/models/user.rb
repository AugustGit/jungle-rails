class User < ActiveRecord::Base

  def self.authenticate_with_credentials(email, password)
    User.where("email = :email", {email: email.strip}).first
    end

    has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, :length => {:within => 6..40}
  validates :password_confirmation, presence: true

end

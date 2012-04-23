require 'digest'

class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regexp    = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  password_regexp = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d)/
  
  validates :name,     :presence     => true,
                       :length       => {:maximum => 50} 
  validates :email,    :presence     => true,
                       :format       => {:with => email_regexp},
                       :uniqueness   => {:case_sensitive => false}
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => {:within => 6..40}
                       #,:format       => {:with => password_regexp}
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    # Return user if email/password match, otherwise nil
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    # Return user if id/cookie_salt match, otherwise nil
    user = find_by_id(id)
    user && user.salt == cookie_salt ? user : nil
  end
  
  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end

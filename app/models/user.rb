class User < ActiveRecord::Base
  has_many :comments
  has_many :posts
  validates_uniqueness_of :username

  has_secure_password

  include BCrypt


  # def password
  #   @password ||= Password.new(password_digest)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_digest = @password
  # end

  # def self.authenticate(email, password)
  #   user = User.find_by_email(email)
  #   return user if user && (user.password == password)
  #   nil
  # end
end

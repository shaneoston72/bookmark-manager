require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id,               Serial
  property :name,             String
  property :password_digest,  Text
  property :email,            String,  :required => true

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, :as => :email_address

end

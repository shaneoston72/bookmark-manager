require 'bcrypt'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id,               Serial
  property :name,             String
  property :password_digest,  Text
  property :email,            String,  :required => true, :unique => true,
                                :format => :email_address,
                                :messages => {
                                  :presence => 'You must provide a valid email address.',
                                  :is_unique => 'Email address already exists.',
                                  :format => 'Email address is formatted incorrectly.'
                                }

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end

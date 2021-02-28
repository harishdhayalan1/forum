class UserSession < Authlogic::Session::Base
  attr_accessor :email, :password
  password_field(:password)
end

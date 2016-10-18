class User < ApplicationRecord

  def generate_token
    self.update_attributes(token: Time.now.to_i)
  end

  def generate_reset_password_token
    self.update_attributes(reset_password_token: self.email)
  end
end

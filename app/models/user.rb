class User < ApplicationRecord

  def generate_token
    self.update_attributes(token: Time.now.to_i)
  end
end

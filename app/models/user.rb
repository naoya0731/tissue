class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name: auth.info.name,
        image_url: auth.info.image,
        password: Devise.friendly_token[0, 20]
      )
      user.set_key
    end

    user
  end

  def set_key
    is_new = false
    while !is_new
      key = SecureRandom.hex(10)
      is_new = true if User.where(key: key).size.zero?
    end
    
    update(key: key)
  end
end

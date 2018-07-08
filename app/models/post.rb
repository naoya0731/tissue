class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :key, use: :slugged
  acts_as_paranoid
  validates :title, presence: true
  validates :body, presence: true

  def self.new_key
    is_new = false
    while !is_new
      key = SecureRandom.hex(10)
      is_new = true if self.where(key: key).size.zero?
    end
    key
  end

  def self.new_guest_id
    is_new = false
    while !is_new
      key = SecureRandom.hex(10)
      is_new = true if self.where(guest_id: key).size.zero?
    end
    key
  end

  def url
    host = Rails.env.development? ? "http://localhost:3000" : "https://tissue-app.herokuapp.com"
    url = "#{host}/posts/#{self.key}"
  end
end

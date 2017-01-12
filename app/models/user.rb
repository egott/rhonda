
class User < ApplicationRecord
  has_many :recipe_books
  has_many :recipes, through: :recipe_books

  def self.from_omniauth(auth)
    puts '*' * 30
    puts 'im in here yo'
    puts '*' * 30
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end

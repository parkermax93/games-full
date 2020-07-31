class User < ApplicationRecord
    has_secure_password
    has_many :games 
    has_many :received_comments, through: :games, source: :comments 
    has_many :comments, dependent: :destroy 
    has_many :commented_games, through: :comments, source: :game

    validates :username, :email, presence: true 
    validates :email, uniqueness: true 

    def self.from_omniauth(response)

        User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
            u.username = response[:info][:name]
            u.email = response[:info][:email]
            u.password = SecureRandom.hex(15)
        end
    end
end
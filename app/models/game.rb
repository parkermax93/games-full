class Game < ApplicationRecord
    belongs_to :user
    belongs_to :genre 
    has_many :comments
    has_many :users, through: :comments 

    validates :name, :developer, :description, presence: true
    validates :release_year, numericality: {only_integer: true}

    # def user_attributes=(user_attributes)
    #     self.user = User.find_or_create_by(username: user_attributes[username]) unless user_attributes[:username].blank?
    # end

    def self.org
        self.order(:name)
    end

end
class Game < ApplicationRecord
    belongs_to :user
    belongs_to :genre 
    has_many :comments, dependent: :destroy 
    has_many :users, through: :comments 

    validates :name, :developer, :description, presence: true
    validates :release_year, numericality: {only_integer: true}


    def self.org
        self.order(:name)
    end

    def self.most_popular
        self.all.sort_by do |game|
            game.comments.length
        end.reverse 
    end
end
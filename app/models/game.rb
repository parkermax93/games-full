class Game < ApplicationRecord
    belongs_to :user
    belongs_to :genre 
    has_many :comments
    has_many :users, through: :comments 

    validates :name, :developer, :description, presence: true
    validates :release_year, numericality: {only_integer: true}
end
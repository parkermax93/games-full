class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :game

    validates :body, presense: true 
end
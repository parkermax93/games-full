class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :game
    accepts_nested_attributes_for :user
    # def user_attributes=(user_attributes)
    #     self.user = User.find_or_create_by(username: user_attributes[:username]) unless user_attributes[:username].blank?
    # end
    # validates :body, presence: true

    def self.org
        self.order(:name)
    end
end
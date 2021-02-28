class User < ActiveRecord::Base
    acts_as_authentic
    has_many :questions, class_name: 'Question', dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true
end

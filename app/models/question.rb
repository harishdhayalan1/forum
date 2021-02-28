class Question < ActiveRecord::Base
  has_many :comments, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :user, class_name: 'User'

  validates :content, presence: true
  validates :title, presence: true
  self.per_page = 10
end

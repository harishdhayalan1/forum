class Comment < ActiveRecord::Base
  has_many :sub_comments, class_name: "Comment", foreign_key: 'parent_id'
  belongs_to :user, class_name: "User"
  PARENT_TYPE_BY_KEY = {
    question: 1,
    comment: 2
  }
  validates :content, presence: true
end

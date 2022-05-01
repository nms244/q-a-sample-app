class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :body, presence: true, length: { maximum: 1000 }
  validates :user_id, presence: true
  validates :question_id, presence: true
end

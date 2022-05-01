class Question < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :solved, inclusion: [true, false]
  validates :user_id, presence: true
end

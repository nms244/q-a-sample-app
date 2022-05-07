class ChangeDatatypeBodyOfQuestions < ActiveRecord::Migration[6.1]
  def change
    change_column :questions, :body, :text
  end
end

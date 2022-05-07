class ChangeDatatypeBodyOfAnswerss < ActiveRecord::Migration[6.1]
  def change
    change_column :answers, :body, :text
  end
end

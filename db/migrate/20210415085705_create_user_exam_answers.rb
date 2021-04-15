class CreateUserExamAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_exam_answers do |t|
      t.references :user_answer, null: false, foreign_key: {to_table: :answers}
      t.references :user_exam, null: false, foreign_key: true

      t.timestamps
    end
  end
end

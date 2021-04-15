class CreateExamQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :exam_questions do |t|
      t.integer :score
      t.references :question, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end
  end
end

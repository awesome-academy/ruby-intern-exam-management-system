class CreateUserExamStatisticDetail < ActiveRecord::Migration[6.1]
  def change
    create_table :user_exam_statistic_details do |t|
      t.integer :count
      t.references :subject, null: false, foreign_key: true
      t.references :user_exam_statistic, null: false, foreign_key: true

      t.timestamps
    end
  end
end

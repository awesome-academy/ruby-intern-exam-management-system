class CreateUserExamStatistic < ActiveRecord::Migration[6.1]
  def change
    create_table :user_exam_statistics do |t|
      t.datetime :date
      t.integer :total_done_exams

      t.timestamps
    end
  end
end

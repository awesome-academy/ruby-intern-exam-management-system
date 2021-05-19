class AddTotalQuestionsToExam < ActiveRecord::Migration[6.1]
  def change
    add_column :exams, :total_number_questions, :int
  end
end

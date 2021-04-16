class ModifyColumnOfUserExam < ActiveRecord::Migration[6.1]
  def change
    change_column_default :user_exams, :spent_time, 0
    change_column_default :user_exams, :status, 0
  end
end

class AddColumnToUserExams < ActiveRecord::Migration[6.1]
  def change
    add_column :user_exams, :status, :int
  end
end

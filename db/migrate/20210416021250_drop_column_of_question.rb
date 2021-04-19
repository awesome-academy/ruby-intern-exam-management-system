class DropColumnOfQuestion < ActiveRecord::Migration[6.1]
  def change
    remove_column :answers, :created_user_id
  end
end

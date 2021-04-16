class RenameColumnOfQuestion < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :type, :choice_type
  end
end

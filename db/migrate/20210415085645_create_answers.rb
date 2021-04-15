class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :content
      t.boolean :correct
      t.references :question, null: false, foreign_key: true
      t.references :created_user, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end

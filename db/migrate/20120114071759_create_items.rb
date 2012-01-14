class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.integer :user_id
      t.integer :borrower_id

      t.timestamps
    end
  end
end

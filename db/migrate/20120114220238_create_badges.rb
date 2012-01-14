class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :imageuri
      t.string :name
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end

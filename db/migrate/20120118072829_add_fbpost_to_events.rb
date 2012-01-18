class AddFbpostToEvents < ActiveRecord::Migration
  def change
    add_column :events, :fb_post, :boolean
  end
end

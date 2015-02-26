class AddColumnUserId < ActiveRecord::Migration
  def change
   add_column :comments, :commentable_user_id, :integer
  end
end

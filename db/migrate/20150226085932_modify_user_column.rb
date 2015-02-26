class ModifyUserColumn < ActiveRecord::Migration
  def change
   rename_column :comments, :commentable_user_id , :user_id
  end
end

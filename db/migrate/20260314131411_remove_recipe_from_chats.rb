class RemoveRecipeFromChats < ActiveRecord::Migration[7.1]
  def change
    remove_column :chats, :recipe_id
  end
end

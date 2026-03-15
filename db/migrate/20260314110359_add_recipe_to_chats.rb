class AddRecipeToChats < ActiveRecord::Migration[7.1]
  def change
    add_reference :chats, :recipe, null: false, foreign_key: true
  end
end

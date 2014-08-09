class AddIsPrivateToChats < ActiveRecord::Migration
  def change
    add_column :chats, :is_private, :boolean
  end
end

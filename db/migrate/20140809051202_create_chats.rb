class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :owner

      t.timestamps
    end
  end
end

class CreateFriendshipRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friendship_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: { to_table: :users }
      t.boolean :pending, default: false

      t.timestamps
    end
  end
end

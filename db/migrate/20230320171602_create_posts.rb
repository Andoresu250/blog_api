class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :post_type
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

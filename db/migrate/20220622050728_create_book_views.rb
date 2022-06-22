class CreateBookViews < ActiveRecord::Migration[6.1]
  def change
    create_table :book_views do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end

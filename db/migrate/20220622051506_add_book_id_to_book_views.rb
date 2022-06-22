class AddBookIdToBookViews < ActiveRecord::Migration[6.1]
  def change
    add_column :book_views, :book_id, :integer
  end
end

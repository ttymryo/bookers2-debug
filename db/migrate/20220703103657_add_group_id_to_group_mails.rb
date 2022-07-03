class AddGroupIdToGroupMails < ActiveRecord::Migration[6.1]
  def change
    add_column :group_mails, :group_id, :integer
  end
end

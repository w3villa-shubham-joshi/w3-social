class AddColumnToFriendRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :friend_requests, :status, :integer
  end
end

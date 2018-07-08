class AddGuestIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :guest_id, :string
  end
end

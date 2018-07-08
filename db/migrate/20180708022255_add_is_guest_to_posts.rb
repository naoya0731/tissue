class AddIsGuestToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :is_guest, :boolean
  end
end

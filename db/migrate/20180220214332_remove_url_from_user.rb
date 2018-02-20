class RemoveUrlFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :url, :string
  end
end

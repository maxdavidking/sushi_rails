class RemoveOrganizationFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :organization, :string
  end
end

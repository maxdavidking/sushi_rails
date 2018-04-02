class RenameColumnPasswordDigestinTableOrganizationstoPassword < ActiveRecord::Migration[5.1]
  def change
    rename_column :organizations, :password_digest, :password
  end
end

class RemoveFileFromDatum < ActiveRecord::Migration[5.2]
  def change
    remove_column :data, :file, :string
  end
end

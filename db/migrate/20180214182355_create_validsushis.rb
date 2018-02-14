class CreateValidsushis < ActiveRecord::Migration[5.1]
  def change
    create_table :validsushis do |t|
      t.string :name
      t.string :endpoint
      t.string :cust_id
      t.string :req_id
      t.string :report_start
      t.string :report_end
      t.string :password

      t.timestamps
    end
  end
end

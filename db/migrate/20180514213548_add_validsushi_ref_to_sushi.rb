class AddValidsushiRefToSushi < ActiveRecord::Migration[5.2]
  def change
    add_reference :sushis, :validsushi, foreign_key: true
  end
end

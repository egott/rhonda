class TakeOutTitle < ActiveRecord::Migration[5.0]
  def change
    change_table :runs do |t|
      t.remove :title
    end
  end
end

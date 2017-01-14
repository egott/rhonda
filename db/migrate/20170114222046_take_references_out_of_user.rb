class TakeReferencesOutOfUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.remove :user_id
    end
  end
end

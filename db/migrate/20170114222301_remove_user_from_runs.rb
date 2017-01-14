class RemoveUserFromRuns < ActiveRecord::Migration[5.0]
  def change
    change_table :runs do |t|
      t.remove :user_id
    end
  end
end

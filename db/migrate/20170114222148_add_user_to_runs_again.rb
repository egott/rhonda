class AddUserToRunsAgain < ActiveRecord::Migration[5.0]
  def change
    change_table :runs do |t|
      t.references :user
    end
  end
end

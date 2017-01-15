class AddUserToRuns < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.references :user
    end
  end
end

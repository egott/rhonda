class Runs < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.string :title
      t.integer :duration
      t.integer :calories
      t.string :fun_fact_about_calories
      t.integer :distance

      t.timestamps
    end
  end
end

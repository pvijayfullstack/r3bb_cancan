class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.string :name
      t.decimal :value
      t.decimal :last
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end

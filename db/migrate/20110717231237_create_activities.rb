class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.references :workout
      t.references :exercise
      t.integer :resistance
      t.integer :repetitions

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end

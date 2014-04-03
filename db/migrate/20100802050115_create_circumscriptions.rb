class CreateCircumscriptions < ActiveRecord::Migration
  def self.up
    create_table :circumscriptions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :circumscriptions
  end
end

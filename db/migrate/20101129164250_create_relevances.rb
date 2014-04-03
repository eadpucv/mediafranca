class CreateRelevances < ActiveRecord::Migration
  def self.up
    create_table :relevances do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :relevances
  end
end

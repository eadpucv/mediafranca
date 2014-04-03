class CreateCitys < ActiveRecord::Migration
  def self.up
    create_table :citys do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :citys
  end
end

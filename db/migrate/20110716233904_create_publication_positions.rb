class CreatePublicationPositions < ActiveRecord::Migration
  def self.up
    create_table :publication_positions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :publication_positions
  end
end

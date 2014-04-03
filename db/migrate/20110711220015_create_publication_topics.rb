class CreatePublicationTopics < ActiveRecord::Migration
  def self.up
    create_table :publication_topics do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :publication_topics
  end
end

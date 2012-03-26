class CreateTopicHitCounts < ActiveRecord::Migration
  def change
    create_table :topic_hit_counts do |t|
      t.string :topic
      t.integer :hits

      t.timestamps
    end
    
    add_index :topic_hit_counts, :topic
  end
end

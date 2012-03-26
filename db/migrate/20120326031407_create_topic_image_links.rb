class CreateTopicImageLinks < ActiveRecord::Migration
  def change
    create_table :topic_image_links do |t|
      t.string :topic
      t.string :link

      t.timestamps
    end
    
    add_index :topic_image_links, :topic
  end
end

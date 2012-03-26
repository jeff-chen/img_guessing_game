class TopicImageLink < ActiveRecord::Base
  def self.random_topic
    rand_id = rand(self.count)
    first(:offset => rand_id).topic
  end
end

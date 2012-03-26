class GameController < ApplicationController
  def index
    @topic = TopicImageLink.random_topic
    @images = TopicImageLink.find_all_by_topic(@topic, :limit => 5).map(&:link)
   # @images = ['http://26.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_500.jpg', 'http://28.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_400.jpg','http://30.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_250.jpg', 'http://30.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_100.jpg', 'http://30.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_75sq.jpg']
    #@topic = 'Obama'
  end
end

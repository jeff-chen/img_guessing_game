class GameController < ApplicationController
  def index
    @images = ['http://26.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_500.jpg', 'http://28.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_400.jpg','http://30.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_250.jpg', 'http://30.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_100.jpg', 'http://30.media.tumblr.com/tumblr_m1evo95ZJ81rrt5tso1_75sq.jpg']
    @topic = 'Obama'
  end
end

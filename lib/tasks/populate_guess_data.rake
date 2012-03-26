require 'json'
require 'net/http'
require 'ruby_debug'

namespace :populate do
  desc 'say hi'
  task :say_hi => :environment do
    #input_file = File.open('mysql_input.csv', 'r')
    #redlines = input_file.readlines
    TopicHitCount.delete_all
    FasterCSV.foreach('mysql_input.csv') do |row|
      if row[1].to_i >= 2 and row[0].length > 3
        TopicHitCount.create!(:topic => row[0], :hits => row[1].to_i)
      end
    end
  end
  
  desc 'Python script'
  task :pyscript => :environment do
    system "python hack.py"
  end
  
  desc 'setup'
  task :setup => [:environment, :pyscript, :say_hi, :get_images]
  
  desc 'get images'
  task :get_images => :environment do
    keyfile = File.open('config/api_keys.txt')
    apikey = keyfile.readlines.first
    TopicImageLink.delete_all
    TopicHitCount.find(:all, :select => "topic").map(&:topic).uniq.each do |t|
      puts "getting stuff for #{t}..."
      x = Net::HTTP.get(URI.parse("http://api.tumblr.com/v2/tagged?tag=#{t.gsub(/\s+/, '+')}&api_key=#{apikey}"))
      parsed = JSON.parse(x) if !x.blank?
      #debugger
      if !x.blank? and parsed["response"].any?
        if parsed["response"].select{|i| i["type"] == "photo"}.map{|i| i["photos"].first["original_size"]["url"]}.size >= 5
          parsed["response"].select{|i| i["type"] == "photo"}.map{|i| i["photos"].first["original_size"]["url"]}.each do |url|
            TopicImageLink.create!(:topic => t, :link => url)
          end
        end
      end
    end
  end
end
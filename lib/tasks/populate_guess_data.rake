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
    #TopicHitCount.create!(:topic => "Obama", :hits => 50)
  end
end
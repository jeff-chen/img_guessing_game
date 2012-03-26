namespace :populate do
  desc 'say hi'
  task :say_hi => :environment do
    puts "Hi!"
  end
end
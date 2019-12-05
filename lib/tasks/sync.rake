desc "build and sync with htttp://assets.integrated-internet.com/sites/SITE"
task :sync, [:site] do |t, args|  
  site    = args[:site] || ask_for_site()[:name]
  puts "building #{site}"
  system "site=#{site} bundle exec middleman build"
  puts "syncing #{site} to http://assets.integrated-internet.com/sites/ from #{ENV['MM_BUILD_DIR']}"
  system "./up.sh #{site}"
end
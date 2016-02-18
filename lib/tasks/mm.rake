desc "just show sites"
task :mm, [:site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  system "/usr/local/bin/sublime ./data/sites/#{site}/site.yml ./source/content/#{site}"
  system "open http://localhost:4567/ && site=#{site} bundle exec middleman"

end
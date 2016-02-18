desc "open site in sublime"
task :edit, [:site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  system "/usr/local/bin/sublime ./data/sites/#{site}/site.yml ./source/content/#{site}"
end

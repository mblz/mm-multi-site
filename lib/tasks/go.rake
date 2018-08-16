desc "go to a site's domain"
task :go, [:site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  site_yml = site_yml(site)
  host     = site_yml[:hostname]
  if host && host !~ /localhost/
    system "open https://www.#{host}"
  else
    system "open http://assets.integrated-internet.com/sites/#{site}"
  end
end
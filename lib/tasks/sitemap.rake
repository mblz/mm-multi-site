desc "ping search engines about a change in sitemap"
task :sitemap, [:site] do |t, args|
  
  site    = args[:site] || ask_for_site()[:name]
  yml     = site_yml(site)
  host    = yml[:hostname]
  sitemap = "http://#{host}/sitemap.xml"

  
  [ "http://www.google.com/webmasters/sitemaps/ping?sitemap=",
    "http://www.bing.com/webmaster/ping.aspx?siteMap="
    ].each do |url|
    system "curl #{url}#{sitemap}"
  end
end

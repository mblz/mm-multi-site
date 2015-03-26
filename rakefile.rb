require 'yaml'

require 'fileutils'

desc "just show sites"
task :show do
  puts ask_for_site()[:name]
end


desc "just show sites"
task :mm, [:site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  system "subl ./data/sites/#{site}/site.yml ./source/content/#{site}"
  system "open http://localhost:4567/ && site=#{site} bundle exec middleman"

end


desc "open site in sublime"
task :edit, [:site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  system "subl ./data/sites/#{site}/site.yml ./source/content/#{site}"
end


desc "create  new sites files with %> rake new_site[SITE_NAME]"
task :new_site, [:name] do |t, args|

	name = args[:name]
  if name.nil?
    puts "Error: No name provided"
    exit 
  end

  # DIRS
  mkdir "source/content/#{name}"
  mkdir "source/partials/#{name}"
  mkdir "data/sites/#{name}"
  
  # Create the assets location
  full_path = File.expand_path("~/Pictures/assets/sites/#{args[:name]}/assets/img/")
  FileUtils.mkdir_p(full_path)


  # YAML  
  %w[site].each do |y|
    cp "data/sites/site/#{y}.yml", "data/sites/#{name}/#{y}.yml"
  end

  # CSS
  cp "source/assets/css/sites/site.css", "source/assets/css/sites/#{name}.css"
  
  # CONTENT
  %w[index services about].each do |f|
    cp "source/content/site/#{f}.html.haml", "source/content/#{name}/#{f}.html.haml"
  end

end

desc "remove a local sites files with #> rake rm_site[SITE_NAME]"
task :rm_site, [:name] do |t, args|
	name = args[:name] || ask_for_site()[:name]
  rm_rf "data/sites/#{name}"
  rm "source/assets/css/sites/#{name}.css"
  rm_rf "source/content/#{name}"
  rm_rf "source/partials/#{name}"
  # Assets
  full_path = File.expand_path("~/Pictures/assets/sites/#{name}")
  rm_rf(full_path)
end

desc "build all sites"
task :build_all do
  sites.each do |site|
    p "site=#{site[:name]} middleman build"
  end
end

desc "create thumbs for this imge dir 'rake thumbs[SITE,DIR/NAM]'"
task :thumbs, [:dir, :site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  dir  = if args[:dir]  
    dir_path = File.expand_path("~/Pictures/assets/sites/#{site}/assets/img/#{args[:dir]}")
  else 
    dir_path = ask_for_img_dir(site)
  end
  system 'mkdir', '-p', dir_path + '/thumb'
  imgs     = Dir.glob(dir_path + "/*[jpg|png|gif]")
  imgs.each do |img_path|
    parts = img_path.split('/')
    name  = parts.delete(parts.last)
    thumb = [parts,"thumb", name].join('/')
    if File.exists?(thumb)
      #p "Exists: #{thumb}"
    else
      p "Thumbnail: #{thumb}"
      format = name.split('.').last
      system "mogrify -resize x100 -background white -gravity center -extent x100 -format #{format} -quality 80 -path '#{parts.join('/')}/thumb' '#{img_path}'"
    end
  end
end

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


desc "build and sync with htttp://assets.integrated-internet.com/sites/SITE"
task :sync, [:site] do |t, args|  
  site    = args[:site] || ask_for_site()[:name]
  puts "building #{site}"
  system "site=#{site} bundle exec middleman build"
  puts "syncing to htttp://assets.integrated-internet.com/sites/#{site}"
  system "./up.sh #{site}"
end

def ask_for_img_dir(site)
  dirs = Dir.glob(File.expand_path("~/Pictures/assets/sites/#{site}/assets/img/*"))
  dirs.each_with_index do |dir, idx|
    puts "#{idx}) #{dir.split('/').last}"
  end
  puts "What directory?"
  i_dir = STDIN.gets.strip
  dirs[i_dir.to_i]  
end

def ask_for_site
  sites.each do |site|
    puts "#{site[:idx]}) #{site[:name]}"
  end
  puts "What site?"
  i_site = STDIN.gets.strip
  site   = sites[i_site.to_i]  
end

def sites
  Dir.glob('data/sites/*').each_with_index.map{|path,idx| {path: path, name: path.split('/').last, idx: idx}}
end

def site_yml site
  YAML.load_file("./data/sites/#{site}/site.yml")
end

desc "create  new sites files with %> rake new_site[SITE_NAME]"
task :new_site, [:name] do |t, args|
	name = args[:name]
  
  # DIRS
  mkdir "source/content/#{name}"
  mkdir "source/partials/#{name}"
  mkdir "data/sites/#{name}"

  # YAML  
  %w[site prices].each do |y|
    cp "data/sites/site/#{y}.yml", "data/sites/#{name}/#{y}.yml"
  end

  # CSS
  cp "source/assets/css/sites/site.css", "source/assets/css/sites/#{name}.css"
  
  # CONTENT
  %w[index services about].each do |f|
    cp "source/content/site/#{f}.html.haml", "source/content/#{name}/#{f}.html.haml"
  end

end

desc "remove a local sites files with %> rake rm_site[SITE_NAME]"
task :rm_site, [:name] do |t, args|
	name = args[:name]
  rm_rf "data/sites/#{name}"
  rm "source/assets/css/sites/#{name}.css"
  rm_rf "source/content/#{name}"
  rm_rf "source/partials/#{name}"
end

desc "build all sites"
task :build_all do
  Dir.glob('data/sites/*').each do |site_path|
    name = site_path.split('/').last
    system "site=#{name} middleman build"
  end
end

desc "create thumbs for this dir"
task :thumbs, [:site, :dir] do |t, args|
  site = args[:site]
  dir  = args[:dir]
  dir_path = File.expand_path("~/Pictures/assets/sites/#{site}/assets/img/#{dir}")
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
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
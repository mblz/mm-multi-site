desc "create a new sites files with %> rake new_site[SITE_NAME]"
task :new_site, [:name] do |t, args|
	name = args[:name]
  
  # DIRS
  mkdir "source/content/#{name}"
  mkdir "source/partials/#{name}"
  mkdir "data/sites/#{name}"

  # YAML  
  %w[site meta prices gallery].each do |y|
    cp "data/sites/site/#{y}.yml", "data/sites/#{name}/#{y}.yml"
  end

  # CSS
  cp "source/css/sites/site.css", "source/css/sites/#{name}.css"
  
  # CONTENT
  %w[index services about].each do |f|
    cp "source/content/site/#{f}.html.haml", "source/content/#{name}/#{f}.html.haml"
  end

  # PARTIAL
  %w[_footer-plus].each do |f|
    cp "source/partials/site/#{f}.html.haml", "source/partials/#{name}/#{f}.html.haml"
  end  
end

desc "remove a local sites files with %> rake rm_site[SITE_NAME]"
task :rm_site, [:name] do |t, args|
	name = args[:name]
  rm_rf "data/sites/#{name}"
  rm "source/css/sites/#{name}.css"
  rm_rf "source/content/#{name}"
  rm_rf "source/partials/#{name}"
end
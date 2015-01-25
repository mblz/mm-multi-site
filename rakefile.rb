desc "create a new sites files with %> rake new_site[SITE_NAME]"
task :new_site, [:name] do |t, args|
	name = args[:name]
  mkdir "source/content/#{name}"
  mkdir "source/partials/#{name}"
  cp "data/sites/site.yml", "data/sites/#{name}.yml"
  %w[index services about].each do |f|
    cp "source/content/site/#{f}.html.haml", "source/content/#{name}/#{f}.html.haml"
  end
end

desc "remove a local sites files with %> rake rm_site[SITE_NAME]"
task :rm_site, [:name] do |t, args|
	name = args[:name]
  rm "data/sites/#{name}.yml"
  rm_rf "source/content/#{name}"
  rm_rf "source/partials/#{name}"
end
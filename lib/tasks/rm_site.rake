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
    Rake::Task[:get_form].reenable
    Rake::Task[:sync].reenable
    Rake::Task[:get_form].invoke(site[:name]) rescue "FORM NOT FOUND ON #{site}"
    Rake::Task[:sync].invoke(site[:name])
    #p "site=#{site[:name]} middleman build"
  end
end
require 'yaml'

require 'fileutils'

require 'open-uri'

require 'json'


task :default => 'show'

Dir.glob('lib/tasks/*.rake').each { |r| load r}

desc "just show sites"
task :show do
  puts ask_for_site()[:name]
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

def test?
  ENV['test'] === '1'
end

def env_url(site, path)
  if test?
    host =  "http://localhost:3000/" 
  else
    host = "http://#{site}.mblz.com/"
  end  
  host + path
end
desc "create thumbs for this imge dir 'rake thumbs[SITE,DIR/NAM]'"
task :thumbs, [:dir, :site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  dir  = if args[:dir]  
    dir_path = File.expand_path("~/Pictures/assets/sites/#{site}/assets/img/#{args[:dir]}")
  else 
    dir_path = ask_for_img_dir(site)
  end
  p dir_path
  #exit
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
      system "mogrify -strip -resize x100 -background white -gravity center -extent x100 -format #{format} -quality 80 -path '#{parts.join('/')}/thumb' '#{img_path}'"
    end
  end
end

# Resize a dir of imgs
# mogrify -resize x800 -background white -gravity center  -format jpg -quality 80 -path ./resized *.JPG

def ask_for_img_dir(site)
  dirs = Dir.glob(File.expand_path("~/Pictures/assets/sites/#{site}/assets/img/*"))
  dirs.each_with_index do |dir, idx|
    puts "#{idx}) #{dir.split('/').last}"
  end
  puts "What directory?"
  i_dir = STDIN.gets.strip
  dirs[i_dir.to_i]  
end
desc "create thumbs for this imge dir 'rake thumbs[SITE,DIR/NAM]'"
task :thumbs, [:dir, :site] do |t, args|
  site = args[:site] || ask_for_site()[:name]
  dir  = if args[:dir]  
    dir_path = File.expand_path("~/Pictures/assets/sites/#{site}/assets/img/#{args[:dir]}")
  else 
    dir_path = ask_for_img_dir(site)
  end
  #p dir_path
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
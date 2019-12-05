module GalleryHelper

	def img_dir_for path
		File.expand_path(ENV['MM_BUILD_DIR']+  "/#{$SITE}/" + path + "*")
	end

	def carousel
	  dir = img_dir_for("assets/img/carousel/")
      Dir.glob(dir).map{|f| f.split('/').last}.sort
	end

	def gallery_dirs
	  dir = img_dir_for("assets/img/gallery/")
      Dir.glob(dir).select {|f| File.directory? f}.sort
	end

	def gallery dir
	  {
		name: File.basename(dir),
		#title: to_title(dir),
		images: gallery_image_paths(dir).map{|path| gallery_image(path)}
	  }
 	end

 	def to_title img
 		s = File.basename(dir).sub(/^\d+/,'')
 		titleize(File.basename(dir).sub(/^\d+/,''))
	 end
	 
	def gallery_image_paths dir
		Dir.glob(dir + "/*[jpg|png|gif]")
	end

	def gallery_image path
      parts = path.split('/')
      name  = parts.delete(parts.last)
      dir   = parts.last
      title = name.sub(/\.(jpg|png|gif)$/i,'').sub(/^\d+/,'') #titleize
      if title =~ /^#{dir}/ || title =~ /^IMG/
    	title = dir
      end
      {title: title, name: name }
	end

	def galleries
		gallery_dirs.map{|dir| gallery(dir)}
	end
end
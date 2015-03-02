module GalleryHelper
	def img_dir_for path
		File.expand_path(data.config.build_dir + path + "*").sub('/site/', "/#{$SITE}/")
	end
	def carousel
    dir = img_dir_for(data.config.carousel_dir)
    Dir.glob(dir).map {|f| f.split('/').last}		
	end

	def gallery_dirs
		dir = img_dir_for(data.config.gallery_dir)
		p dir
    Dir.glob(dir).select {|f| File.directory? f}		
	end

	def gallery dir
		{
			name: File.basename(dir),
			title: titleize(File.basename(dir).sub(/^\d+/,'')),
			images: gallery_image_paths(dir).map{|path| gallery_image(path)}
		}
 	end

	def gallery_image_paths dir
		Dir.glob(dir + "/*[jpg|png|gif]")
	end

	def gallery_image path
    parts = path.split('/')
    name  = parts.delete(parts.last)
    title = titleize(name.sub(/\.(jpg|png|gif)$/,'').sub(/^\d+/,''))

    {title: title, name: name }
	end

	def galleries
		gallery_dirs.map{|dir| gallery(dir)}
	end
end
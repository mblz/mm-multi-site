module GalleryHelper
	def gallery_dirs
    dir = (data.config.build_dir + data.config.gallery_dir + "*").sub('/site/', "/#{$SITE}/")
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
    title = titleize(name.sub(/\.(jpg|png|gif)$/,''))

    {title: title, name: name }
	end

	def galleries
		gallery_dirs.map{|dir| gallery(dir)}
	end
end
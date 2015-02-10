module GalleryHelper
	def gallery_dirs
    dir = "/Users/vudu/Pictures/assets/sites/#{$SITE}/assets/img/gallery/*"
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
		Dir.glob(dir + "/*[jpg|png]")
	end

	def gallery_image path
    parts = path.split('/')
    name  = parts.delete(parts.last)
    title = titleize(name.sub(/\.(jpg|png)$/,''))

    {title: title, name: name }
	end

	def galleries
		gallery_dirs.map{|dir| gallery(dir)}
	end
end
module ParadiseHelper
	def paradise_sun i
		["Shaded", "PartiallyShaded", "", "FullSun"][i]
		#["Shaded", "Moderate", "Full"][i-1]
	end
	def paradise_water i
		#["Low", "Moderate", "High"][i-1]
		["Light", "Weekly", "", "Heavy"][i]
	end

	def paradise_category(id)
		#{}"Palms Trees Shrubs Flowers GroundCover Cacti".split[id-1]
		site("categories").find{|c| c[:id] == id}
	end

	def location_matrix(cat, location)
		matrix = cat[:matrix]
		rows, cols = matrix.split('x')
		s = ""
		x = 1
		1.upto(cols.to_i) do
			1.upto(rows.to_i) do
				matrix = products_at_matrix_location(cat, x)
				if location.to_i == x
					s += " <span class='glyphicon glyphicon-map-marker' style='color:firebrick'></span> "
				else
			    s += " <span class='glyphicon glyphicon-certificate #{'empty' if matrix.empty?}' title='#{matrix}'></span> "
			  end
  			x += 1
			end
			s += '<br/>'
		end
		s
	end

	def products_at_matrix_location(category, location)
		site(:products).find_all{|p| (p[:product_category_id] == category[:id] && p.location == location)}.map{|p| p['name']}.join(',')
	end

	def item_title_value item, prop
		prop_value = item[prop.to_s.downcase]
		if prop_value.present?
			"<li>#{prop}: <b>#{item[prop.downcase]}</b></li>"
		end
	end

	def test?
	  ENV['test'] === '1'
	end

	def env_url(path)
	  if test?
	    host =  "http://localhost:3000" 
	  else
	    host = "http://#{ENV['site']}.mblz.com"
	  end  
	  host + path
	end	
end
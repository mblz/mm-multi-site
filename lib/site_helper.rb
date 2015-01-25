$SITE = ENV["site"] || 'site'
p "$SITE=#{$SITE}"

# if $SITE
#   p "Booting up $SITE=#{$SITE}"
# else
#   p "$SITE NOT FOUND - using default"
# end


module SiteHelper

	def site
  	site_data = eval("data.sites.#{$SITE}")

    rescue
      throw("Could not find default site data in data/sites/#{$SITE}")
	end	

	def site_partial part, *args
		partial("partials/sites/#{$SITE}/#{part}", *args)
	rescue
		partial("partials/sites/site/#{part}", *args)
	end

	def site_img img, *args
		image_tag(site_img_path(img), *args)
	end
	def site_img_path img, *args
	  "//assets.integrated-internet.com/sites/#{$SITE}/img/#{img}" 
	end	

	def click_to_call
		site_partial('click_to_call')
	end

	def titleize title
    ActiveSupport::Inflector.titleize(title)
  end
end

# So we can use setting.name rather than setting[:name]
class ::Hash
  def method_missing(name)
    return self[name] if key? name
    self.each { |k,v| return v if k.to_s.to_sym == name }
    super.method_missing name
  end
end

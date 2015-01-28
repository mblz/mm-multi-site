$SITE = ENV["site"] || 'site'
p "$SITE=#{$SITE}"

# if $SITE
#   p "Booting up $SITE=#{$SITE}"
# else
#   p "$SITE NOT FOUND - using default"
# end


module SiteHelper

	def page_title
		meta = site(:meta)[current_page.path.sub(/\.html/,'')] || {}
		current_page.data.title || meta[:title] || site.title
	end
	def site part = nil
  	if not part
      eval("data.sites.#{$SITE}.site")#.with_indifferent_access
    else
      eval("data.sites.#{$SITE}.#{part}")
    end

    rescue
      throw("Could not find default site data in data/sites/#{$SITE}")
	end	

	def site_partial part, *args
		partial("partials/#{$SITE}/#{part}", *args)
	rescue
		partial("partials/site/#{part}", *args)
	end

	def site_img img, *args
		image_tag(site_img_path(img), *args)
	end

	# Keep images remotely
	def site_img_path img, *args
	  "//assets.integrated-internet.com/sites/#{$SITE}/img/#{img}" 
	end	

	def click_to_call
		site_partial('click_to_call')
	end

	def titleize title
    ActiveSupport::Inflector.titleize(title)
  end

  def nav_active?(nav)

    if nav.is_a?(String)
      path = "#{nav.downcase}.html"  
    elsif nav.cnt
    	path = "content/#{$SITE}/#{nav.title.downcase}.html"
    else 
    	path = nav.link
    end
    current_page.path == path
 	
  end

  def email_form
    questions        = CGI.escape(site.contact_form.fields.map{|q| "#{q}:"}.join("\n\n"))
    email_string     = "?subject=#{site.contact_form.subject}&body=#{questions}"
    
    mail_to(site.email + email_string, site.email, target: :_blank, class: 'btn btn-success')

  	
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

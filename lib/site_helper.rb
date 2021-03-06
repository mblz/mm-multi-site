$SITE = ENV["site"] || 'site'
$DEMO = ENV["demo"] || false
p "$SITE=#{$SITE}"


# if $SITE
#   p "Booting up $SITE=#{$SITE}"
# else
#   p "$SITE NOT FOUND - using default"
# end


module SiteHelper
  
  def sites
    Dir.glob('data/sites/*').map{|ss| ss.split('/').last}
  end

	def page_title
		#meta = site(:meta)[current_page.path.sub(/\.html/,'')] || {} rescue {}
		(current_page.data.title || site.title).gsub(/<\/?[^>]*>/,"")
	end

  # Shortcut to data for the site currently loaded
  def site part = nil

  	if not part
      eval("@app.data.sites.#{$SITE}.site") #rescue nil
    else
      eval("@app.data.sites.#{$SITE}.#{part}")
    end

    rescue
      throw("Could not find default site data in data/sites/#{$SITE}")
	end	

  # over-ride partials for individual sites
	def site_partial part, *args
		partial("partials/#{$SITE}/#{part}", *args)
	rescue
    #p "Exception: no site partial : #{$!}"
		partial("partials/site/#{part}", *args)
	end

  def site_link_to title, page, *options
    link_to title, "/content/#{$SITE}/#{page}.html", *options
  end

  def has_side_menu
    partial("partials/#{$SITE}/side_menu") rescue nil
  end

	def click_to_call
		site_partial('click_to_call')
	end

  def nav_active?(nav)
    if nav.is_a?(String)
      path = "#{nav.downcase}.html"  
    elsif nav.cnt
    	path = "content/#{$SITE}/#{parameterize nav.title}.html"
    else 
    	path = nav.link
    end
    current_page.path == path
 	
  end

  def icon_for(nav)
    icon = case nav
      when 'Testimonials'
        'heart'
      when 'Gallery'
        'picture'        
    end
    
    if icon
      "<i class='fa fa-#{icon}'></i>"
    end
  end

  def mblz_host
    development? ? 'localhost:3000' : "#{$SITE}.mblz.com"
  end
  # Create a custom email link for the site - uses data.yml
  def email_form
    questions        = CGI.escape(site.contact_form.fields.map{|q| "#{q}:"}.join("\n\n"))
    email_string     = "?subject=#{site.contact_form.subject}&body=#{questions}"    
    mail_to(site.email + email_string, site.email, target: :_blank)
  end

  def titleize title
    ActiveSupport::Inflector.titleize(title)
  end

  def parameterize title
    ActiveSupport::Inflector.parameterize(title)
  end

end


# So we can use setting.name rather than setting[:name]
# class ::Hash
#   def method_missing(name)
#     return self[name] if key? name
#     self.each { |k,v| return v if k.to_s.to_sym == name }
#     super.method_missing name
#   end
# end

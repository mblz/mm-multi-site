xml.instruct!
xml.urlset 'xmlns' => "https://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap.resources.select { |page| page.path =~ /\.html/ }.each do |page|
  	if /^content/ =~ page.path
      next if /^content\/#{$SITE}*/ !~ page.path
      next if /^content\/#{$SITE}\/index\.html$/ =~ page.path
    end
  	next if /^404/ =~ page.path
  
  # make sure these pages have content 
  # %w[testimonials referrals portfolio faqs clients gallery].each do |test|
  #   if site[test].blank?
  #     if page.path == 
  #   end
  # end

    xml.url do
      xml.loc('https://www.' + site.hostname + url_for("#{site.host}/#{page.path}", {relative: false}))
      xml.lastmod Date.today.to_time.iso8601
      xml.changefreq page.data.changefreq || "monthly"
      xml.priority page.data.priority || "0.5"
    end
  end
end
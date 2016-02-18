desc "get pages"
task :get_pages, [:site] do |t, args| 

  site        = args[:site] || ask_for_site()[:name]
  system "rm -rf ./source/content/#{site}/pages"
  system "mkdir -p ./source/content/#{site}/pages"

  #s_json      = open("http://localhost:3000/pages") {|f| f.read }
  s_json      = open("http://#{site}.mblz.com/pages") {|f| f.read }
  
  pages       = JSON.parse(s_json)#map{|j| {title: j[:title], text: j[:text] }}

  pages.each do |page|    
    title       = page['title']
    short_title = title.gsub(/\s+/, "-").downcase
    is_root     = page['parent_id'].nil?
    short_title = 'index' if is_root

    File.open("source/content/#{site}/pages/#{short_title}.html.md.erb", "w") do |file|

      s = "---\n"
      s += "title: #{title}\n"
      s += "description: #{page['meta_description']}\n"
      s += "keywords: #{page['meta_keywords']}\n"
      s += "---\n\n"

      if is_root
        s += "<%\n if carousel.present? \n"
           s += "   content_for :carousel, site_partial('carousel')\n"
        s += "end \n%>\n\n"
      end

      unless page['subtitle'].to_s == ''
        s += "<h1 class='page-header'>#{page['title']} <small>#{page['subtitle']}</small></h1>\n\n"
      else
        s += "# #{title}\n\n"
      end
      
      unless page['image'].to_s == ''
        s += "<div class='pull-right text-right'><img class='img-responsive' src='#{page['image']}'/></div>\n\n"
      end   

      s += page['text']

      file.write s
    

    end    
  end


  #s_json      = open("http://localhost:3000/pages/1162") {|f| f.read }
  #json        = JSON.parse(s_json).#map{|j| {title: j[:title], text: j[:text] }}

  # File.open("data/sites/#{site}/pages.yml", "w") do |file|
  #   file.write a.to_yaml
  # end  
end
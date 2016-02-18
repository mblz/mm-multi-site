desc "get form reviews"
task :get_reviews, [:site] do |t, args| 
  site        = args[:site] || ask_for_site()[:name]
  url         = env_url(site, 'reviews?mblz=1')   
  s_json      = open(url) {|f| f.read }
  json        = JSON.parse(s_json)#.map{|j| {comment: j['comment'], initials: j['initials'], title: j['title'], created_at: j['created_at']}}
  File.open("data/sites/#{site}/reviews.yml", "w") do |file|
    file.write json.to_yaml
  end  
end
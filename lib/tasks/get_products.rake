desc "get products"
task :get_products, [:site] do |t, args| 
  site        = args[:site] || ask_for_site()[:name]
  puts site
  url         = env_url(site, 'products?mblz=1')   
  p url
  s_json      = open(url) {|f| f.read }
  json        = JSON.parse(s_json)
  File.open("data/sites/#{site}/products.yml", "w") do |file|
    file.write json.to_yaml
  end  
end


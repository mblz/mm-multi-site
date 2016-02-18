desc "get form from mblz"
task :get_form, [:site] do |t, args| 
  site        = args[:site] || ask_for_site()[:name]
  s_json      = open("http://#{site}.mblz.com/forms") {|f| f.read }
  json        = JSON.parse(s_json).map{|j| {name: j['name'], title: j['title'], options: j['options'], required: j['required'], field_type: j['field_type'].downcase }}
  #p JSON.parse(json).to_yaml

  File.open("data/sites/#{site}/form.yml", "w") do |file|
    file.write json.to_yaml
  end  
end
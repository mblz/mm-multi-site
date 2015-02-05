require "lib/site_helper"
helpers SiteHelper

# Mucked with assets generally
#set :http_prefix, "//assets.integrated-internet.com/sites/#{$SITE ? $SITE : 'default'}/"

activate :directory_indexes

# Use relative URLs
activate :relative_assets

set :relative_links, true


set :css_dir, 'assets/css'
set :js_dir, 'assets/js'
set :images_dir, 'assets/img'

page "/sitemap.xml", :layout => false


# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end


# Build-specific configuration
configure :build do
  # Only include this sites' content
  ignore /^content\/(?!#{$SITE})/
  ignore /^\.git/

  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.build_before = true # default: false
  deploy.method       = :rsync
  deploy.host         = '104.236.159.21'
  # deploy.port       = 5555
  deploy.path         = "~/static/sites/#{$SITE}"
  deploy.user         = 'mblz' # no default
  #deploy.flags  = '--exclude assets'
  #   # Optional Settings
  #   # deploy.user  = 'tvaughan' # no default
  #   # deploy.port  = 5309 # ssh port, default: 22
  #   # deploy.clean = true # remove orphaned files on remote host, default: false
  #   # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
end

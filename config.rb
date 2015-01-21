require "lib/site_helper"
helpers SiteHelper

activate :directory_indexes

# Use relative URLs
activate :relative_assets

set :relative_links, true

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'


activate :deploy do |deploy|
  deploy.method = :git
end

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end


# Build-specific configuration
configure :build do
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


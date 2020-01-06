require "lib/sym_helper"
include SymHelper
link_imgs
ln_index

require "lib/site_helper"
helpers SiteHelper
include SiteHelper

require "lib/gallery_helper"
helpers GalleryHelper
include GalleryHelper

# BUILD_DIR="/Volumes/Files/assets/newsites/site/"

# Site specific configs
# if $SITE == 'wlm'
#   data.sites.wlm.product_categories.each do |category|
#     proxy "/content/wlm/products/#{category[:name]}.html", "/content/wlm/products/template.html", :locals => { :category => category }
#   end
# end


require "lib/paradise_helper"
helpers ParadiseHelper


# class Response < Hashie::Mash
#   disable_warnings
# end

activate :directory_indexes
activate :relative_assets
set :relative_links, true

# activate :sprockets do |c|
#   c.expose_middleman_helpers = true
# end

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true


set :css_dir, 'assets/css'
set :js_dir, 'assets/js'
set :images_dir, 'assets/img'

page "/sitemap.xml", :layout => false


# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
#   activate :automatic_alt_tags
# end


# Build-specific configuration
configure :build do
  set :build_dir, ENV['MM_BUILD_DIR'] + $SITE
  
  
  # Only include this sites' content
  ignore /^content\/(?!#{$SITE})/

  ignore /^content\/#{$SITE}\/pages/
  
  ignore /^assets\/css\/sites\/(?!#{$SITE})/
  ignore /^\.git/

  ignore /^content\/wlm\/products\/template\.html$/

  # make sure these pages have content 
  %w[testimonials referrals portfolio faqs clients reviews].each do |test|
    if site(test).nil?
      ignore /^#{test}\.html/
    end
  end
  
  if galleries.empty?
    ignore 'gallery.html'
  end

  activate :minify_css
  # activate :minify_javascript 
  # activate :imageoptim
  # activate :imageoptim do |options|
  #   # Use a build manifest to prevent re-compressing images between builds
  #   options.manifest = true
  
  #   # Silence problematic image_optim workers
  #   options.skip_missing_workers = true
  
  #   # Cause image_optim to be in shouty-mode
  #   options.verbose = false
  
  #   # Setting these to true or nil will let options determine them (recommended)
  #   options.nice = true
  #   options.threads = true
  
  #   # Image extensions to attempt to compress
  #   options.image_extensions = %w(.png .jpg .gif .svg)
  
  #   # Compressor worker options, individual optimisers can be disabled by passing
  #   # false instead of a hash
  #   options.advpng    = { :level => 4 }
  #   options.gifsicle  = { :interlace => false }
  #   options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
  #   options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
  #   options.optipng   = { :level => 6, :interlace => false }
  #   options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
  #   options.pngout    = { :copy_chunks => false, :strategy => 0 }
  #   options.svgo      = {}
  # end  
  # activate :automatic_alt_tags

  #activate :gzip
  activate :minify_html 
  #ignore /assets\/fonts\//

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

# activate :deploy do |deploy|
#   deploy.build_before = true # default: false
#   deploy.method       = :rsync
#   deploy.host         = '104.236.159.21'
#   # deploy.port       = 5555
#   deploy.path         = "~/static/sites/#{$SITE}"
#   deploy.user         = 'mblz' # no default
#   #deploy.flags  = '--exclude assets'
#   #   # Optional Settings
#   #   # deploy.user  = 'tvaughan' # no default
#   #   # deploy.port  = 5309 # ssh port, default: 22
#   #   # deploy.clean = true # remove orphaned files on remote host, default: false
#   #   # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
# end

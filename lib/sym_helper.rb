module SymHelper
  def link_imgs
    system "unlink ~/dev/middleman/mm-multi-site/source/assets/img"
    system "ln -s /Volumes/Files/assets/sites/#{$SITE}/assets/img ~/dev/middleman/mm-multi-site/source/assets/img"
  end

  def ln_index
    system "unlink ~/dev/middleman/mm-multi-site/source/index.html.haml"
    system "unlink ~/dev/middleman/mm-multi-site/source/index.html.md.erb"
    system "ln -s ~/dev/middleman/mm-multi-site/source/content/#{$SITE}/index.html.haml ~/dev/middleman/mm-multi-site/source/index.html.haml" 
    system "ln -s ~/dev/middleman/mm-multi-site/source/content/#{$SITE}/index.html.md.erb ~/dev/middleman/mm-multi-site/source/index.html.md.erb"    
  end
end

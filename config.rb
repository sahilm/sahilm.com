config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:source] = 'src'
activate :inliner
activate :meta_tags
activate :directory_indexes
activate :syntax, line_numbers: false, css_class: 'code'
activate :blog
activate :autoprefixer
configure :production do
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript
  activate :minify_html
  activate :imageoptim
  activate :gzip do |gz|
    gz.overwrite = true
  end
end

configure :development do
  activate_livereload
end

def activate_livereload
  activate :livereload do |reload|
    reload.no_swf = true
  end
rescue StandardError => e
  $stderr.puts e
end

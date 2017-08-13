config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:source] = 'src'

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :inliner
activate :meta_tags
activate :directory_indexes
activate :syntax, line_numbers: false
activate :blog
activate :autoprefixer do |prefix|
  prefix.browsers = 'last 2 versions'
end

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
  activate :livereload
end

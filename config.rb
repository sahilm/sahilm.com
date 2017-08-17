config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:source] = 'src'
page '/feed.xml', layout: false
page '/sitemap.xml', layout: false
activate :blog do |blog|
  blog.permalink = '{title}.html'
  blog.sources = '{title}.html'
end
activate :inliner
activate :meta_tags
activate :directory_indexes
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: false, css_class: 'syntax-highlight'
activate :autoprefixer
configure :production do
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :minify_html
  activate :imageoptim
  activate :gzip do |gz|
    gz.overwrite = ENV.key?('GZIP_NO_OVERWRITE') ? false : true
    gz.exts = %w(.css .htm .html .js .svg .xhtml .ttf .json .xml .ico .eot .otf)
  end
end

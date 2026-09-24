# frozen_string_literal: true

require 'middleman-core/renderers/redcarpet'
require_relative 'lib/anchor_renderer'
require_relative 'lib/site_helpers'

helpers SiteHelpers

Time.zone = 'Dublin'
config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:source] = 'src'
set :site_origin, 'https://sahilm.github.io'
page '/feed.xml', layout: false
page '/sitemap.xml', layout: false
activate :blog do |blog|
  blog.permalink = '{title}.html'
  blog.sources = 'articles/{title}.html'
  blog.layout = 'article'
  blog.prefix = '/'
end
page '/', layout: 'index'
page '/404.html', layout: '404', directory_index: false
activate :inliner
activate :meta_tags
activate :directory_indexes
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, renderer: AnchorRenderer
activate :syntax, line_numbers: false, css_class: 'syntax-highlight'
configure :production do
  set :http_prefix, '/sahilm.com'
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :minify_html
end

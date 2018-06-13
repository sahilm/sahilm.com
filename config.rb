# frozen_string_literal: true

require 'middleman-s3_sync'
require 'middleman-core/renderers/redcarpet'
require_relative 'lib/anchor_renderer'
require_relative 'lib/helpers'

helpers Helpers

Time.zone = 'Dublin'
config[:css_dir] = 'css'
config[:js_dir] = 'js'
config[:source] = 'src'
page '/feed.xml', layout: false
page '/sitemap.xml', layout: false
activate :blog do |blog|
  blog.permalink = '{title}.html'
  blog.sources = 'articles/{title}.html'
  blog.layout = 'article'
  blog.prefix = '/'
end
page '/', layout: 'index'
page '/404.html', layout: '404'
activate :inliner
activate :meta_tags
activate :directory_indexes
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true, renderer: AnchorRenderer
activate :syntax, line_numbers: false, css_class: 'syntax-highlight'
configure :production do
  activate :asset_hash
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :minify_html
  activate :imageoptim do |options|
    options.manifest = false
    options.image_extensions = %w[.png .jpg .jpeg .gif .svg]
    options.jpegoptim = {allow_lossy: true, strip: ['all'], max_quality: 85}
  end
  activate :s3_sync do |s3_sync|
    s3_sync.bucket = 'sahilm.com'
    s3_sync.region = 'eu-west-1'
    s3_sync.delete = true
    s3_sync.after_build = false
    s3_sync.prefer_gzip = false
    s3_sync.path_style = true
    s3_sync.reduced_redundancy_storage = false
    s3_sync.acl = 'public-read'
    s3_sync.encryption = false
    s3_sync.prefix = ''
    s3_sync.version_bucket = false
    s3_sync.index_document = 'index.html'
    s3_sync.error_document = '404/index.html'
  end

  %w[text/html
     text/xml
     text/plain
     image/x-icon
     image/vnd.microsoft.icon
     application/json
     application/atom+xml
     application/rss+xml
     application/xml].each do |mime_type|
    caching_policy mime_type, public: true, max_age: 0, must_revalidate: true
  end

  default_caching_policy public: true, max_age: (60 * 60 * 24 * 365)
end
